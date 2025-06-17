Scriptname VAoNRebukeUndeadScript extends activemagiceffect  
{This script manage all effects covered by the rebuke undead menu.}

import message
import actor
import actorbase
import objectreference
import debug
import FormList
import Utility
import Spell
import GlobalVariable

Message[] Property arRebukeUndeadMessageList  Auto  
{This array contains all messages created for the Rebuke Undead effect.}

; Declare missing variables
Actor acActivator
Actor acTarget
Int iCasterSoulPotence
Int iVictimSoulPotence
Bool bIsFreeWilled
Bool blPlayerCheater
Int[] iUnforgivingHeartCount


float property fDelay = 0.75 auto
                  {time to wait before Spawning Ash Pile}
; float property fDelayAlpha = 1.65 auto
;                   {time to wait before Setting alpha to zero.}
float property fDelayEnd = 1.65 auto
                  {time to wait before Removing Base Actor}
float property ShaderDuration = 0.00 auto
                  {Duration of Effect Shader.}
EffectShader property MagicEffectShader auto
Bool property bSetAlphaZero = True auto
Bool property bSetAlphaToZeroEarly = False Auto
int iPushedButton

int iMenuLevel = 0

Event OnEffectStart(Actor akTarget, Actor akCaster)
    ; Assign targets
    acActivator = akCaster
    acTarget = akTarget

    ; Skip if target is essential
    If akTarget.IsEssential()
        Return
    EndIf

    ; Calculate Caster Soul Potence
    iCasterSoulPotence = acActivator.GetActorValue("magicka") as int + acActivator.GetActorValue("conjuration") as int + acActivator.GetActorValue("speechcraft") as int + acActivator.GetActorValue("dragonsouls") as int + acActivator.GetLevel()

    ; Calculate Victim Soul Potence
    int tempAggression = acTarget.GetActorValue("aggression") as int
    int tempConfidence = acTarget.GetActorValue("confidence") as int
    int tempAssistance = acTarget.GetActorValue("assistance") as int
    int tempAggressionSum = (tempAggression + tempConfidence + tempAssistance) * 10
    iVictimSoulPotence = (acTarget.GetActorValue("magicka") as int) + (acTarget.GetActorValue("speechcraft") as int) + tempAggressionSum + acTarget.GetLevel()

    ; Apply randomness
    iCasterSoulPotence += Utility.RandomInt(-20, 20)
    iVictimSoulPotence += Utility.RandomInt(-20, 20)

    ; Show message box and store result
    iPushedButton = arRebukeUndeadMessageList[0].Show()

    ; Assume target is not free-willed initially
    bIsFreeWilled = False

    ; Handle button result
    If iPushedButton == 0
        GotoState("Subjugate")
        Return
    ElseIf iPushedButton == 1
        GotoState("Come")
        Return
    ElseIf iPushedButton == 2
        GotoState("Equip")
        Return
    ElseIf iPushedButton == 3
        GotoState("Wait")
        Return
    ElseIf iPushedButton == 4
        GotoState("Improve")
        Return
    ElseIf iPushedButton == 5
        GotoState("Destroy")
        Return
    ElseIf iPushedButton == 6
        GotoState("Configure")
        Return
    EndIf
EndEvent


State Subjugate

  Event OnBeginState()

  if acTarget.IsInFaction(faMinionState)

   Debug.Notification("You cannot subjugate your own minions!")

    GotoState("EndRebuke")
    Return

 endif
 
  if iCasterSoulPotence > iVictimSoulPotence

       if acTarget.IsInCombat()

          acTarget.StopCombat()

      endif  

   Debug.Notification("It is one of your minions now")
    acTarget.SetActorValue("aggression", 1)
    acTarget.SetActorValue("confidence", 4)
    acTarget.SetActorValue("morality", 0)
    acTarget.SetActorValue("assistance", 1)
    acTarget.AddToFaction(faMinionState)
    acTarget.SetPlayerTeammate(true,true)   
  
    arRebukeUndeadMessageList[4].Show()

  else
 
     arRebukeUndeadMessageList[3].Show() 

     bIsFreeWilled = TRUE

    Debug.Notification("The undead is still free willed.")

  endif

  GotoState("EndRebuke")
  Return

  EndEvent

endState


State Come

  Event OnBeginState()

  if !(acTarget.IsInFaction(faMinionState))

   Debug.Notification("You cannot command free willed undead!")

    GotoState("EndRebuke")
    Return

 endif

  arRebukeUndeadMessageList[5].Show() 

  acTarget.SetAv("WaitingForPlayer", 0)

 if (acTarget.HasPerk(prkWait))

    acTarget.RemovePerk(prkWait)
    acTarget.AddPerk(prkFollowMe)

 else

    acTarget.AddPerk(prkFollowMe)

Endif

  acTarget.EnableAI(true)

  acTarget.EvaluatePackage()

  GotoState("EndRebuke")
  Return

  EndEvent

endState

State Equip

  Event OnBeginState()

  if !(acTarget.IsInFaction(faMinionState))

   Debug.Notification("You cannot command free willed undead!")

    GotoState("EndRebuke")
    Return

 endif

  arRebukeUndeadMessageList[6].Show() 

  acTarget.OpenInventory(true)

  GotoState("EndRebuke")
  Return

  EndEvent

endState

State Wait

  Event OnBeginState()

  if !(acTarget.IsInFaction(faMinionState))

   Debug.Notification("You cannot command free willed undead!")

    GotoState("EndRebuke")
    Return

 endif

  arRebukeUndeadMessageList[7].Show() 

  acTarget.SetAv("WaitingForPlayer", 1)

 if (acTarget.HasPerk(prkFollowMe))

    acTarget.RemovePerk(prkFollowMe)
    acTarget.AddPerk(prkWait)

 else

    acTarget.AddPerk(prkWait)

Endif

  acTarget.EnableAI(false)
 
  GotoState("EndRebuke")

  Return

  EndEvent

endState

State Improve

  Event OnBeginState()

  if !(acTarget.IsInFaction(faMinionState))

   Debug.Notification("You cannot improve free willed undead!")

    GotoState("EndRebuke")
    Return

 endif

  int iImprovementChoice =arRebukeUndeadMessageList[1].Show() 

  if iImprovementChoice == 0

     if (acActivator.GetItemCount(arRequiredComponents[0])>=1)

        arRebukeUndeadMessageList[9].Show()

        acTarget.ModAV("health", 100)
        acTarget.ModAV("healrate", 5)
        acTarget.ModAV("combathealthregenmult", 0.20)
        acTarget.ModAV("healratemult", 100)
	acActivator.RemoveItem(arRequiredComponents[0], 1)

      else

        arRebukeUndeadMessageList[8].Show()
      
      endif

        GotoState("EndRebuke")

         Return

  elseif iImprovementChoice == 1

     if (acActivator.GetItemCount(arRequiredComponents[1])>=1)

        arRebukeUndeadMessageList[11].Show()


        acTarget.ModAV("magicka", 100)
        acTarget.ModAV("magickarate", 5)
        acTarget.ModAV("magickaratemult", 100)
	acActivator.RemoveItem(arRequiredComponents[1], 1)

      else

        arRebukeUndeadMessageList[10].Show()

      endif

        GotoState("EndRebuke")
        Return
      

elseif iImprovementChoice == 2

     if (acActivator.GetItemCount(arRequiredComponents[2])>=1  && acActivator.GetItemCount(arRequiredTools[0])>=1)

        arRebukeUndeadMessageList[13].Show()

        acTarget.ModAV("stamina", 100)
        acTarget.ModAV("staminarate", 5)
        acTarget.ModAV("carryweight", 100)
        acTarget.ModAV("staminaratemult", 100)
	acActivator.RemoveItem(arRequiredComponents[2], 1)

      else

        arRebukeUndeadMessageList[12].Show()

      endif
      
	  GotoState("EndRebuke")
        Return      

elseif iImprovementChoice == 3

     if (acActivator.GetItemCount(arRequiredComponents[3])>=1)

        arRebukeUndeadMessageList[15].Show()

        acTarget.SetAV("aggression", 2)
        acTarget.ModAV("speedmult", 100)
        acTarget.ModAV("weaponspeedmult", 1.20)
        acTarget.ModAV("leftweaponspeedmult", 1.20)
        acTarget.ModAV("unarmeddamage", 20)
        acTarget.ModAV("attackdamagemult", 0.20)
        acTarget.ModAV("bowstaggerbonus", 5)
	acActivator.RemoveItem(arRequiredComponents[3], 1)

      else

        arRebukeUndeadMessageList[14].Show()
      
      endif

        GotoState("EndRebuke")
        Return

elseif iImprovementChoice == 4

     if ((acActivator.GetItemCount(arRequiredComponents[4])>=1) && acActivator.GetItemCount(arRequiredTools[1])>=1 && acActivator.GetItemCount(arRequiredTools[2])>=1 && acActivator.GetItemCount(arRequiredTools[3])>=1 && acActivator.GetItemCount(arRequiredTools[4])>=1)

        arRebukeUndeadMessageList[17].Show()

        acTarget.SetAV("assistance", 2)
        acTarget.ModAV("detectliferange", 100)
        acTarget.ModAV("onehanded", 25)
        acTarget.ModAV("twohanded", 25)
        acTarget.ModAV("blocking", 25)
        acTarget.ModAV("archery", 25)
        acTarget.ModAV("sneak", 25)
        acTarget.ModAV("critchance", 10)	
	acActivator.RemoveItem(arRequiredComponents[4], 1)
        
      else

        arRebukeUndeadMessageList[16].Show()
      
      endif

        GotoState("EndRebuke")
        Return

  elseif iImprovementChoice == 5

	iUnforgivingHeartCount[0] = acActivator.GetItemCount(arRequiredComponents[5])
	iUnforgivingHeartCount[1] = acActivator.GetItemCount(arRequiredComponents[6])

     if (acActivator.GetItemCount(arRequiredTools[1])>=1 && acActivator.GetItemCount(arRequiredTools[2])>=1 && acActivator.GetItemCount(arRequiredTools[3])>=1 && acActivator.GetItemCount(arRequiredTools[4])>=1) && ((iUnforgivingHeartCount[0]>=1) || (iUnforgivingHeartCount[1]>=1))

	if 	(iUnforgivingHeartCount[0] >	0)
		
		acActivator.RemoveItem(arRequiredComponents[5], 1)

		blPlayerCheater = FALSE
	else
		acActivator.RemoveItem(arRequiredComponents[6], 1)

		blPlayerCheater = TRUE

	endif

        arRebukeUndeadMessageList[19].Show()

        acTarget.GetLeveledActorBase().SetProtected(true)
        acTarget.ModAV("mass", 0.2)
        acTarget.ModAV("damageresist", 20)
        acTarget.ModAV("poisonresist", 20)
        acTarget.ModAV("fireresist", 20)
        acTarget.ModAV("frostresist", 20)
        acTarget.ModAV("electricresist", 20)
        acTarget.ModAV("magicresist", 20)


        GotoState("CheckForPunishment")
        Return
        
      else

        arRebukeUndeadMessageList[18].Show()
      
      endif

        GotoState("EndRebuke")
        Return

EndIf


  EndEvent

endState

State Destroy

  Event OnBeginState()

  if !(acTarget.IsInFaction(faMinionState))

   Debug.Notification("You cannot destroy free willed undead!")

    GotoState("EndRebuke")
    Return

 endif

  int iDestructionChoice = arRebukeUndeadMessageList[2].Show()


  if iDestructionChoice == 0

	   if ((acTarget.GetItemCount(arRequiredAllergens[0])>=1)  && (acActivator.GetItemCount(arRequiredComponents[7])>=1) && ((acTarget.GetItemCount(arRequiredAllergens[1])>=2) ||  (acTarget.GetItemCount(arRequiredAllergens[2])>=2)))

          arRebukeUndeadMessageList[21].Show()

       		if acTarget.GetLeveledActorBase().IsEssential()

			        acTarget.GetLeveledActorBase().SetEssential(false)

		      endif
		      if acTarget.GetLeveledActorBase().IsInvulnerable()

			        acTarget.GetLeveledActorBase().SetInvulnerable(false)

		      endif
		      if acTarget.GetLeveledActorBase().IsProtected()
    bIsFreeWilled = TRUE
			        acTarget.GetLeveledActorBase().SetProtected(false)

		      endif

             acTarget.SetPlayerTeammate(false)

		acTarget.RemoveFromFaction(faMinionState)

		bIsFreeWilled == TRUE

	      acTarget.RemoveItem(arRequiredAllergens[0], 1, false)
	      
            if acTarget.GetItemCount(arRequiredAllergens[1])<2
	         acTarget.RemoveItem(arRequiredAllergens[1], (acTarget.GetItemCount(arRequiredAllergens[1])))
		       acTarget.RemoveItem(arRequiredAllergens[2], (2 - (acTarget.GetItemCount(arRequiredAllergens[1]))))
	    else
                acTarget.RemoveItem(arRequiredAllergens[1], 2)
           endif

             GotoState("IncinerateUndead")
             Return
 
		    else

      				arRebukeUndeadMessageList[20].Show()

      				GotoState("EndRebuke")
                           Return
    
   		    endif   

  	   elseif  iDestructionChoice == 1

	    arRebukeUndeadMessageList[22].Show()

	    GotoState("EndRebuke")
           Return

	  endif

  EndEvent

endState


State IncinerateUndead

  Event OnBeginState()

  Game.ForceThirdPerson()

  Game.ShakeCamera(afStrength = 0.2, afDuration = 2.0)

  acTarget.PlayImpactEffect(idImmolationEffect)

  acTarget.Kill(acActivator)

  acTarget.SetCriticalStage(acTarget.CritStage_DisintegrateStart)
    if  MagicEffectShader != none
      MagicEffectShader.play(acTarget,ShaderDuration)
    endif
    if bSetAlphaToZeroEarly
      acTarget.SetAlpha (0.0,True)
    endif
  utility.wait(fDelay)     
  acTarget.AttachAshPile()
  utility.wait(fDelayEnd)
  if  MagicEffectShader != none
      MagicEffectShader.stop(acTarget)
  endif
  if bSetAlphaZero == True
      acTarget.SetAlpha (0.0,True)
  endif
  acTarget.SetCriticalStage(acTarget.CritStage_DisintegrateEnd)

  RegisterForSingleLOSLost(Game.GetPlayer(), acTarget) 

 GotoState("WaitForLostLOS")
 Return

  EndEvent

endState


State CheckForPunishment

  Event OnBeginState()
    if blPlayerCheater
        bIsFreeWilled = TRUE
        acTarget.SetPlayerTeammate(false, false)
        acTarget.SetActorValue("confidence", 4)
        acTarget.SetActorValue("morality", 0)
        acTarget.SetActorValue("assistance", 0)
        acTarget.RemoveFromFaction(faMinionState)
        acTarget.AddToFaction(faOblivionRevenge)
        acTarget.SetActorValue("aggression", 3)
        acTarget.StartCombat(Game.GetPlayer())
        GotoState("EndRebuke")
        Return
    else
        bIsFreeWilled = FALSE
        GotoState("EndRebuke")
        Return
    endif
  EndEvent

endState


State WaitForLostLOS

Event OnLostLOS(Actor akViewer, ObjectReference akTarget)

    acTarget.DeleteWhenAble()	
   GotoState("EndRebuke") 
   Return

endEvent

endState

State Configure

  Event OnBeginState()

  iPushedButton = arRebukeUndeadMessageList[25].Show()

  if iPushedButton == 0

  GotoState("SetFollowDelay") 
  Return

  elseif iPushedButton == 1

  GotoState("SetPutrefactionTimer") 
  Return

  endif


  EndEvent

endState

State SetFollowDelay

  Event OnBeginState()

  float fFollowDelay

 fFollowDelay = glFollowDelay.GetValue()

  Debug.Notification("Follow Delay currently set to " + fFollowDelay + " RL seconds.")

  iPushedButton = arRebukeUndeadMessageList[26].Show()

  if iPushedButton == 0

  glFollowDelay.SetValue(2.0)

  fFollowDelay = glFollowDelay.GetValue()
  Debug.Notification("Follow Delay changed to " + fFollowDelay + " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 1

  glFollowDelay.SetValue(10.0)

  fFollowDelay = glFollowDelay.GetValue()
  Debug.Notification("Follow Delay changed to " + fFollowDelay + " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 2

  glFollowDelay.SetValue(20.0)

  fFollowDelay = glFollowDelay.GetValue()
  Debug.Notification("Follow Delay changed to " + fFollowDelay + " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 3

  glFollowDelay.SetValue(30.0)

  fFollowDelay = glFollowDelay.GetValue()
  Debug.Notification("Follow Delay changed to " + fFollowDelay + " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 4

  glFollowDelay.SetValue(40.0)

  fFollowDelay = glFollowDelay.GetValue()
  Debug.Notification("Follow Delay changed to " + fFollowDelay + " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 5

  glFollowDelay.SetValue(60.0)

  fFollowDelay = glFollowDelay.GetValue()
  Debug.Notification("Follow Delay changed to " + fFollowDelay + " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 6

  glFollowDelay.SetValue(120.0)

  fFollowDelay = glFollowDelay.GetValue()
  Debug.Notification("Follow Delay changed to " + fFollowDelay + " RL seconds.")
  GotoState("EndRebuke") 
  Return

  endif

  EndEvent

endState

State SetPutrefactionTimer

  Event OnBeginState()


  float fPutrefactionTimer
  glPutrefactionTimer.SetValue(960.0)
  fPutrefactionTimer = glPutrefactionTimer.GetValue()

  Debug.Notification("Putrefaction Timer currently set to " + fPutrefactionTimer + " RL seconds.")

  iPushedButton = arRebukeUndeadMessageList[27].Show()

  if iPushedButton == 0

  glPutrefActionTimer.SetValue(960.0)

  fPutrefactionTimer = glPutrefactionTimer.GetValue()
  Debug.Notification("Putrefaction Timer changed to " + fPutrefactionTimer +  " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 1

  glPutrefactionTimer.SetValue(1440.0)

   fPutrefactionTimer = glPutrefactionTimer.GetValue()
  Debug.Notification("Putrefaction Timer changed to " + fPutrefactionTimer +  " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 2

  glPutrefactionTimer.SetValue(2880.0)

  fPutrefactionTimer = glPutrefactionTimer.GetValue()
  Debug.Notification("Putrefaction Timer changed to " + fPutrefactionTimer +  " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 3

  glPutrefactionTimer.SetValue(8640.0)

  fPutrefactionTimer = glPutrefactionTimer.GetValue()
  Debug.Notification("Putrefaction Timer changed to " + fPutrefactionTimer +  " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 4

  glPutrefactionTimer.SetValue(20160.0)

  fPutrefactionTimer = glPutrefactionTimer.GetValue()
  Debug.Notification("Putrefaction Timer changed to " + fPutrefactionTimer +  " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 5

  glPutrefactionTimer.SetValue(40320.0)

  fPutrefactionTimer = glPutrefactionTimer.GetValue()
  Debug.Notification("Putrefaction Timer changed to " + fPutrefactionTimer +  " RL seconds.")
  GotoState("EndRebuke") 
  Return

  elseif iPushedButton == 6

  glPutrefactionTimer.SetValue(86400.0)

  fPutrefactionTimer = glPutrefactionTimer.GetValue()
  Debug.Notification("Putrefaction Timer changed to " + fPutrefactionTimer +  " RL seconds.")
  GotoState("EndRebuke") 
  Return

  endif


  EndEvent

endState





State EndRebuke

  Event OnBeginState()

  if  bIsFreeWilled == FALSE

  if acTarget.IsPlayerTeammate() == FALSE

     acTarget.SetPlayerTeammate(true,true)       

  endif

  endif

  EndEvent

endState

Ingredient[] Property inRequiredIngredient  Auto  

Actor Property acActivator  Auto  

Actor Property acTarget  Auto  

Int Property iCasterSoulPotence  Auto  

Int Property iVictimSoulPotence  Auto  

Faction Property faMinionState  Auto  

Bool Property bIsFreeWilled  Auto  

MiscObject[] Property arRequiredComponents  Auto  
{These are the deadric artefacts or the materials required to improve or destroy the undead minion.}

MiscObject[] Property arRequiredTools  Auto  
{These are the tools required to improve or destroy the undead. In general, they are not consumed.}

Ingredient[] Property arRequiredAllergens  Auto  
{These are ingredients used in the destruction of the undead.}

ImpactDataSet Property idImmolationEffect  Auto  


SPELL Property spImmortalVisualEffect  Auto  

Bool Property blPlayerCheater  Auto  

Int[] Property iUnforgivingHeartCount  Auto  

Faction Property faOblivionRevenge  Auto  





Perk Property prkFollowMe  Auto  

Perk Property prkWait  Auto  

GlobalVariable Property glFollowDelay  Auto  

GlobalVariable Property glPutrefactionTimer  Auto  

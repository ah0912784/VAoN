Scriptname VAoNInteractWithEnslavedSoul extends ObjectReference  

Import Actor

Import ActorBase

import globalvariable

Import Math

import message

import game

Event OnInit() 

	Self.BlockActivation()

EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

  Self.BlockActivation()


If ((akOldContainer!= Game.GetPlayer()) && (akNewContainer == None) && (blSoulImprisoned != True))

   
    int iCount = 0
    obSpecificSkull = self   
    actor acActor = akOldContainer as Actor
    actorbase abActor = acActor.GetLeveledActorBase() 
    strSoulClass = (abActor.GetClass()).GetName() as string
    strSoulRace = (abActor.GetRace()).GetName() as string
    strSoulName = abActor.GetName() as string
    iSoulLevel = acActor.GetLevel() 

    While (iCount < flSoulStatisticValue.Length)
		 flSoulStatisticValue[iCount] = acActor.GetBaseActorValue(strSoulStatisticLabel[iCount]) as float
		 iCount += 1
     EndWhile

     iCount = 0

     blSoulImprisoned = True

     Debug.Notification("The soul essence has been trapped into the skull...")


endif

 
endEvent


Event OnActivate(ObjectReference akActionRef)

acActivator = akActionRef as actor

string strVariant = "th"

If (iSoulLevel == 1)
    strVariant = "st"
elseif (iSoulLevel == 2)
    strVariant = "nd"
elseif (iSoulLevel == 3)
    strVariant = "rd"
Endif

iActivatorLevel = acActivator.GetLevel() 

Debug.Notification("This skull holds the spirit of " +  strSoulName + " ( " + iSoulLevel + strVariant +" level " + strSoulRace + " " + strSoulClass + " )")

iMenuLevel = 0

iBranchSector = 0

int iCount = 0

intKillWorth = 0


While (iCount < flSkillRank.Length)

	If (((iSoulLevel/iActivatorLevel) as float) * 100 > flSkillRank[iCount])

	    intKillWorth = iCount +1		

	EndIf		

	iCount += 1

EndWhile

iCount = 0

While (iCount < flSoulStatisticValue.Length)
	   glSoulGlobalStatistic[iCount].SetValue(flSoulStatisticValue[iCount])
         flActivatorStatisticValue[iCount] = acActivator.GetBaseActorValue(strSoulStatisticLabel[iCount]) as float
	  iCount += 1
EndWhile

Debug.Notification("You are summoning the energies of the trapped soul...")

iCount = 0

iConvRatio = 0

If (flActivatorStatisticValue[7] >= 75)

iConvRatio = 2

elseif (flActivatorStatisticValue[7] >= 25)

iConvRatio = 3

elseif (flActivatorStatisticValue[7] < 25)

iConvRatio = 4

EndIf

If (iSoulLevel > iActivatorLevel)

iConvRatio -= 1

elseif (iSoulLevel < iActivatorLevel)

iConvRatio += 1

EndIf


flMemoryAbsorptionRatio = 1/((iConvRatio) as float)

Debug.Notification("You absorb statistics from the soul at a 1:" + iConvRatio + " ratio.")

int iButtonPushed = msgSkullMenuOptions[0].Show()


If (iButtonPushed == 0)

    GoToState("ActivateSkull")
    Return

elseif (iButtonPushed == 1)

acActivator.AddItem(Self, 1)

    GoToState("DeactivateSkull")
    Return

Endif


endEvent

state ActivateSkull

Event OnBeginState()


iMenuLevel = 1

iBranchSector = 0

int iButtonPushed = msgSkullMenuOptions[1].Show()

If (iButtonPushed == 0)

    GoToState("ImproveAttribute")
    Return

elseif (iButtonPushed == 1)

    GoToState("SelectSkillGroup")
    Return

elseif (iButtonPushed == 2)

    GoToState("DeactivateSkull")
    Return

Endif



endEvent

endState


state ImproveAttribute

Event OnBeginState()

iMenuLevel = 2

iBranchSector = 0

int iButtonPushed = msgSkullMenuOptions[2].Show()

If (iButtonPushed < 3)

   flSkillBoost = (floor((flSoulStatisticValue[iButtonPushed] -  flActivatorStatisticValue[iButtonPushed])* flMemoryAbsorptionRatio)) as float

   if flSkillBoost > flAttributeCapPerUse

       flSkillBoost = flAttributeCapPerUse

   endif

   string strAlternateText = strSoulStatisticLabel[iButtonPushed] 

   strStatisticToChange = strSoulStatisticLabel[iButtonPushed]
    Debug.Notification("The soul has " + strAlternateText + " : " + (flSoulStatisticValue[iButtonPushed]  as int))
    Debug.Notification("You can increase this trait by + " + (flSkillBoost as int))

    GoToState("ConfirmChange")
    Return

elseif (iButtonPushed == 3)

    GoToState("ActivateSkull")
    Return

Endif

EndEvent

endState



state SelectSkillGroup

Event OnBeginState()

iMenuLevel = 2

iBranchSector = 1

int iButtonPushed = msgSkullMenuOptions[3].Show()

If (iButtonPushed == 0)

    GoToState("ImproveCombatSkill")
    Return

elseif (iButtonPushed == 1)

    GoToState("ImproveMagicSkill")
    Return

elseif (iButtonPushed == 2)

    GoToState("ImproveStealthSkill")
    Return

elseif (iButtonPushed == 3)

    GoToState("ActivateSkull")
    Return

Endif

EndEvent

endState


state ImproveCombatSkill

Event OnBeginState()

iMenuLevel = 3

iBranchSector = 0

int iButtonPushed = msgSkullMenuOptions[4].Show()

int iSelectionCode = iButtonPushed +  iCombatMenuAdj[iButtonPushed]

If (iButtonPushed < 6)

   flSkillBoost = (floor((flSoulStatisticValue[iSelectionCode] -  flActivatorStatisticValue[iSelectionCode])* flMemoryAbsorptionRatio)) as float

   if flSkillBoost > flSkillCapPerUse

       flSkillBoost = flSkillCapPerUse

   endif

  string strAlternateText

  if (strSoulStatisticLabel[iSelectionCode] == "OneHanded")

    strAlternateText = "One Handed"

  elseif (strSoulStatisticLabel[iSelectionCode] == "HeavyArmor")

    strAlternateText = "Heavy Armor"

  elseif (strSoulStatisticLabel[iSelectionCode] == "TwoHanded")

    strAlternateText = "Two Handed"   

   else

    strAlternateText = strSoulStatisticLabel[iSelectionCode]

  endif

   strStatisticToChange = strSoulStatisticLabel[iSelectionCode]
    Debug.Notification("The soul has " + strAlternateText + " : " + (flSoulStatisticValue[iSelectionCode]  as int))
    Debug.Notification("You can increase this trait by + " + (flSkillBoost as int))

    GoToState("ConfirmChange")
    Return

elseif (iButtonPushed == 6)

    GoToState("SelectSkillGroup")
    Return

Endif

EndEvent

endState


state ImproveMagicSkill

Event OnBeginState()

iMenuLevel = 3

iBranchSector = 1

int iButtonPushed = msgSkullMenuOptions[5].Show()

int iSelectionCode = iButtonPushed +  iMagicMenuAdj[iButtonPushed]

If (iButtonPushed < 6)

   flSkillBoost = (floor((flSoulStatisticValue[iSelectionCode] -  flActivatorStatisticValue[iSelectionCode])* flMemoryAbsorptionRatio)) as float

   if flSkillBoost > flSkillCapPerUse

       flSkillBoost = flSkillCapPerUse

   endif

   strStatisticToChange = strSoulStatisticLabel[iSelectionCode]
   string strAlternateText = strSoulStatisticLabel[iSelectionCode]
    Debug.Notification("The soul has " + strAlternateText + " : " + (flSoulStatisticValue[iSelectionCode]  as int))
    Debug.Notification("You can increase this trait by + " + (flSkillBoost as int))

    GoToState("ConfirmChange")
    Return

elseif (iButtonPushed == 6)

    GoToState("SelectSkillGroup")
    Return

Endif

EndEvent

endState


state ImproveStealthSkill

Event OnBeginState()

iMenuLevel = 3

iBranchSector = 2

int iButtonPushed = msgSkullMenuOptions[6].Show()

int iSelectionCode = iButtonPushed +  iStealthMenuAdj[iButtonPushed]

If (iButtonPushed < 6)

   flSkillBoost = (floor((flSoulStatisticValue[iSelectionCode] -  flActivatorStatisticValue[iSelectionCode])* flMemoryAbsorptionRatio)) as float

   if flSkillBoost > flSkillCapPerUse

       flSkillBoost = flSkillCapPerUse

   endif

 string strAlternateText

  if (strSoulStatisticLabel[iSelectionCode] == "LightArmor")

    strAlternateText == "Light Armor"

  else

    strAlternateText = strSoulStatisticLabel[iSelectionCode]

  endif

   strStatisticToChange = strSoulStatisticLabel[iSelectionCode]
    Debug.Notification("The soul has " + strAlternateText + " : " + (flSoulStatisticValue[iSelectionCode]  as int))
    Debug.Notification("You can increase this trait by + " + (flSkillBoost as int))

    GoToState("ConfirmChange")
    Return

elseif (iButtonPushed == 6)

    GoToState("SelectSkillGroup")
    Return

Endif

EndEvent

endState

state ConfirmChange

Event OnBeginState()

int iButtonPushed = msgSkullMenuOptions[7].Show()

int iSourceMenu = (iMenuLevel * 10) + iBranchSector

If (iButtonPushed == 0)

GoToState("ChangeStatistic")
Return   

elseif (iButtonPushed == 1)

	if (iSourceMenu == 20)
	    GoToState("ImproveAttribute")
    	    Return   
	elseif (iSourceMenu == 30)
	    GoToState("ImproveCombatSkill")
    	    Return   
	elseif (iSourceMenu == 31)
	    GoToState("ImproveMagicSkill")
    	    Return   
 	elseif (iSourceMenu == 32)
	    GoToState("ImproveStealthSkill")
    	    Return   
	else
	   Debug.Notification("Original menu couldn't be found...")
	    GoToState("ActivateSkull")
    	    Return   
	endif

EndIf

EndEvent

endState

state ChangeStatistic

Event OnBeginState()

int iSkillIncrement = floor(flSkillBoost)

If ((strStatisticToChange == "health") || (strStatisticToChange == "magicka") || (strStatisticToChange == "stamina"))


	flOldScore = acActivator.GetBaseActorValue(strStatisticToChange)

	flNewScore = flOldScore + (iSkillIncrement as float)
 
	acActivator.SetActorValue(strStatisticToChange, flNewScore)	

	flOldScore = 0
	flNewScore = 0

Else

Game.IncrementSkillBy(strStatisticToChange, iSkillIncrement)

EndIf

string strAlternateText

  if (strStatisticToChange == "OneHanded")

    strAlternateText = "One Handed"

  elseif (strStatisticToChange == "HeavyArmor")

    strAlternateText = "Heavy Armor"

  elseif (strStatisticToChange == "TwoHanded")

    strAlternateText = "Two Handed"   

  elseif (strStatisticToChange == "LightArmor")

    strAlternateText = "Light Armor"

   else

    strAlternateText = strStatisticToChange

  endif

int iNewValue = (acActivator.GetBaseActorValue(strStatisticToChange)) as int

Debug.MessageBox("Your new value for " + strAlternateText + " is " +   iNewValue)


If (blSpiritSparkAbsorbed != TRUE)

    GoToState("GatherSparks")
    Return

Else

    GoToState("DeactivateSkull") 
    Return

EndIf

Return

EndEvent

endState


state GatherSparks

Event OnBeginState()

int iCount = 0

int iCountB = 0

iAbsorbedSpiritSparks = 0

string strAlternateText

While (iCount < strSoulStatisticLabel.Length)

	intRankWorth = 0
       
	While (iCountB < flSkillRank.Length)

		If (flActivatorStatisticValue[iCount] > flSkillRank[iCountB])

                  intRankWorth = iCountB + 1

		EndIf

	  iCountB += 1

      EndWhile

  intCurrentSkillKill = (glKillStatisticCount[iCount].GetValue() as int) + intKillWorth + intRankWorth

  if (strSoulStatisticLabel[iCount] == "OneHanded")

    strAlternateText = "One Handed"

  elseif (strSoulStatisticLabel[iCount] == "HeavyArmor")

    strAlternateText = "Heavy Armor"

  elseif (strSoulStatisticLabel[iCount] == "TwoHanded")

    strAlternateText = "Two Handed"   

  elseif (strSoulStatisticLabel[iCount] == "LightArmor")

    strAlternateText = "Light Armor"

   else

    strAlternateText = strSoulStatisticLabel[iCount]

  endif


  If (intCurrentSkillKill >= 100)

	intCurrentSkillKill -= 100


	If ((strSoulStatisticLabel[iCount] == "health") || (strSoulStatisticLabel[iCount] == "magicka") || (strSoulStatisticLabel[iCount] == "stamina"))

	flOldScore = acActivator.GetBaseActorValue(strSoulStatisticLabel[iCount]) as float

	flNewScore = flOldScore +1
 
	acActivator.SetActorValue(strSoulStatisticLabel[iCount], flNewScore)	

	flOldScore = 0
	flNewScore = 0

	else

	IncrementSkillBy(strSoulStatisticLabel[iCount], 1)	

	EndIf

	iAbsorbedSpiritSparks += 1

	If (iAbsorbedSpiritSparks == 1)

	strSoulSparkEffect = "The fragmented memories of the absorbed souls begin to make sense and your " + strAlternateText

	elseif (iAbsorbedSpiritSparks > 1)

	strSoulSparkEffect += ",  "+ strAlternateText 

	EndIf	

  EndIf

	glKillStatisticCount[iCount].SetValue(intCurrentSkillKill) 

     If ((iAbsorbedSpiritSparks == 1) && (iCount == (strSoulStatisticLabel.Length - 1)))

	strSoulSparkEffect += " increase by +1."

	elseif ((iAbsorbedSpiritSparks > 1) && (iCount == (strSoulStatisticLabel.Length - 1)))

	strSoulSparkEffect += " all increase by +1."

	EndIf	

	If ((iAbsorbedSpiritSparks > 0) && (iCount == (strSoulStatisticLabel.Length - 1)))
	
	Debug.MessageBox(strSoulSparkEffect)

	 blSpiritSparkAbsorbed = TRUE

	EndIf

  iCount += 1

EndWhile

GoToState("DeactivateSkull") 
Return

EndEvent

endState


state DeactivateSkull

Event OnBeginState()

int iCount = 0

While (iCount < flSoulStatisticValue.Length)
	   glSoulGlobalStatistic[iCount].SetValue(0)
	  iCount += 1
EndWhile

EndEvent

endState


ObjectReference Property obSpecificSkull  Auto  


Float[] Property flSoulStatisticValue  Auto  

String[] Property strSoulStatisticLabel  Auto  

String Property strSoulName  Auto  

String Property strSoulClass  Auto  

Bool Property blSoulImprisoned  Auto  

String Property strSoulRace  Auto  

String Property strSoulSparkEffect  Auto 

Actor Property acActivator  Auto  

Message[] Property msgSkullMenuOptions  Auto  

GlobalVariable[] Property glSoulGlobalStatistic  Auto  

Float[] Property flActivatorStatisticValue  Auto  

Float Property flMemoryAbsorptionRatio  Auto  

Int Property iSoulLevel  Auto  

Int Property iActivatorLevel  Auto  

Int Property iMenuLevel  Auto  

String Property strStatisticToChange  Auto  

Float Property flSkillBoost  Auto  

Int Property iBranchSector  Auto  

Int[] Property iCombatMenuAdj  Auto  

Int[] Property iMagicMenuAdj  Auto  

Int[] Property iStealthMenuAdj  Auto  

Float Property flAttributeCapPerUse  Auto  

Float Property flSkillCapPerUse  Auto  

Int Property intKillWorth  Auto  

Int Property iAbsorbedSpiritSparks  Auto  

Int Property intRankWorth  Auto  

GlobalVariable[] Property glKillStatisticCount  Auto  

Float[] Property flSkillRank  Auto

Bool Property blSpiritSparkAbsorbed  Auto  

Int Property intCurrentSkillKill  Auto  

Int Property iConvRatio  Auto  

Float Property flNewScore  Auto  

Float Property flOldScore  Auto  

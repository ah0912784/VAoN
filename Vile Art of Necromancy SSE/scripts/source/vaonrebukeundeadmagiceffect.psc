Scriptname VAoNRebukeUndeadMagicEffect extends ActiveMagicEffect
{
Spell effect script for Rebuke Undead. Handles minion control and improvement.
The flow of the script is as follows:
1. OnEffectStart: Initializes the effect, checks if the target is essential, and attempts to subjugate.
2. Checks for essential status and subjugation.
3. If not essential and not subjugated, the target will attempt to be subjugated
4. If subjugated, the target becomes a minion and can be commanded.
5. subsequent casts of the spell will show a menu with options to command, improve, destroy, or configure the undead.
}

import message
import actor
import actorbase
import objectreference
import debug
import FormList
import Utility
import Spell
import GlobalVariable

; Properties
Message[] Property arRebukeUndeadMessageList  Auto
MiscObject[] Property arRequiredComponents  Auto
MiscObject[] Property arRequiredTools  Auto
Ingredient[] Property arRequiredAllergens  Auto
ImpactDataSet Property idImmolationEffect  Auto
Spell Property spImmortalVisualEffect  Auto
Faction Property faMinionState  Auto
Faction Property faOblivionRevenge  Auto
Perk Property prkFollowMe  Auto
Perk Property prkWait  Auto
GlobalVariable Property glFollowDelay  Auto
GlobalVariable Property glPutrefactionTimer  Auto
EffectShader Property MagicEffectShader auto

; Variables
Actor acActivator
Actor acTarget
Int iCasterSoulPotence
Int iVictimSoulPotence
Bool bIsFreeWilled
Bool blPlayerCheater
Int[] iUnforgivingHeartCount

float property fDelay = 0.75 auto
float property fDelayEnd = 1.65 auto
float property ShaderDuration = 0.00 auto
Bool property bSetAlphaZero = True auto
Bool property bSetAlphaToZeroEarly = False Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    acActivator = akCaster
    acTarget = akTarget

    if akTarget.IsEssential()
        Debug.Notification("Target is essential and cannot be affected.")
        return
    endif
    if TrySubjugate()
        SubjugateMinion()

    ; else
    ;     ShowRebukeMenu()
    endif
    
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Cleanup or reset if needed
EndEvent

Function CalculateSoulPotence()
    iCasterSoulPotence = acActivator.GetActorValue("magicka") as int + acActivator.GetActorValue("conjuration") as int + acActivator.GetActorValue("speechcraft") as int + acActivator.GetActorValue("dragonsouls") as int + acActivator.GetLevel()
    int tempAggression = acTarget.GetActorValue("aggression") as int
    int tempConfidence = acTarget.GetActorValue("confidence") as int
    int tempAssistance = acTarget.GetActorValue("assistance") as int
    int tempAggressionSum = (tempAggression + tempConfidence + tempAssistance) * 10
    iVictimSoulPotence = (acTarget.GetActorValue("magicka") as int) + (acTarget.GetActorValue("speechcraft") as int) + tempAggressionSum + acTarget.GetLevel()
    iCasterSoulPotence += Utility.RandomInt(-20, 20)
    iVictimSoulPotence += Utility.RandomInt(-20, 20)
EndFunction

Function ShowRebukeMenu()
    int iPushedButton = arRebukeUndeadMessageList[0].Show()
    if iPushedButton == 0
        TrySubjugate()
    elseif iPushedButton == 1
        TryCommandCome()
    elseif iPushedButton == 2
        TryCommandEquip()
    elseif iPushedButton == 3
        TryCommandWait()
    elseif iPushedButton == 4
        TryImprove()
    elseif iPushedButton == 5
        TryDestroy()
    elseif iPushedButton == 6
        ShowConfigureMenu()
    endif
EndFunction

Bool Function TrySubjugate()
    if acTarget.IsInFaction(faMinionState)
        Debug.Notification("The undead is already your minion.")
        return false
    else
        return true
    endif
EndFunction

Function TryCommandCome()
    if !(acTarget.IsInFaction(faMinionState))
        Debug.Notification("You cannot command free willed undead!")
        return
    endif
    arRebukeUndeadMessageList[5].Show()
    acTarget.SetAv("WaitingForPlayer", 0)
    if (acTarget.HasPerk(prkWait))
        acTarget.RemovePerk(prkWait)
    endif
    acTarget.AddPerk(prkFollowMe)
    acTarget.EnableAI(true)
    acTarget.EvaluatePackage()
EndFunction

Function TryCommandEquip()
    if !(acTarget.IsInFaction(faMinionState))
        Debug.Notification("You cannot command free willed undead!")
        return
    endif
    arRebukeUndeadMessageList[6].Show()
    acTarget.OpenInventory(true)
EndFunction

Function TryCommandWait()
    if !(acTarget.IsInFaction(faMinionState))
        Debug.Notification("You cannot command free willed undead!")
        return
    endif
    arRebukeUndeadMessageList[7].Show()
    acTarget.SetAv("WaitingForPlayer", 1)
    if (acTarget.HasPerk(prkFollowMe))
        acTarget.RemovePerk(prkFollowMe)
    endif
    acTarget.AddPerk(prkWait)
    acTarget.EnableAI(false)
EndFunction

Function TryImprove()
    ; You can move the improvement logic here, similar to above
    arRebukeUndeadMessageList[1].Show()
    Debug.Notification("Improvement logic not implemented in this refactor.")
EndFunction

Function TryDestroy()
    ; You can move the destruction logic here, similar to above
    arRebukeUndeadMessageList[2].Show()
    Debug.Notification("Destruction logic not implemented in this refactor.")
EndFunction

Function ShowConfigureMenu()
    arRebukeUndeadMessageList[25].Show()
    Debug.Notification("Configure menu logic not implemented in this refactor.")
EndFunction


Bool Function SubjugateMinion()
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
    else
        arRebukeUndeadMessageList[3].Show()
        bIsFreeWilled = TRUE
        Debug.Notification("The undead is still free willed.")
        return False
    endif
    return True
EndFunction

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
Message[] Property improveUndeadMssgList Auto
Message[] Property destroyUndeadMessageList Auto
Message[] Property YorN Auto
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
    if CanSubjugate()
        CalculateSoulPotence()
        SubjugateMinion()

    else
        ShowRebukeMenu()
    endif
    
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Cleanup or reset if needed
EndEvent

Function CalculateSoulPotence()
    iCasterSoulPotence = acActivator.GetActorValue("magicka") as int + acActivator.GetActorValue("conjuration") as int + acActivator.GetLevel()
    int tempAggression = acTarget.GetActorValue("aggression") as int
    int tempConfidence = acTarget.GetActorValue("confidence") as int
    int tempAssistance = acTarget.GetActorValue("assistance") as int
    int tempAggressionSum = (tempAggression + tempConfidence + tempAssistance) * 10
    iVictimSoulPotence = (acTarget.GetActorValue("magicka") as int) + tempAggressionSum + acTarget.GetLevel()
    iCasterSoulPotence += Utility.RandomInt(-20, 20)
    iVictimSoulPotence += Utility.RandomInt(-20, 20)
EndFunction



Bool Function CanSubjugate()
    if acTarget.IsInFaction(faMinionState)
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
    arRebukeUndeadMessageList[1].Show()
    acTarget.OpenInventory(true)
EndFunction

Function TryCommandWait()
    if !(acTarget.IsInFaction(faMinionState))
        Debug.Notification("You cannot command free willed undead!")
        return
    endif
    arRebukeUndeadMessageList[3].Show()
    acTarget.SetAv("WaitingForPlayer", 1)
    if (acTarget.HasPerk(prkFollowMe))
        acTarget.RemovePerk(prkFollowMe)
    endif
    acTarget.AddPerk(prkWait)
    acTarget.EnableAI(false)
EndFunction

Bool Function TryImprove() 
    if !(acTarget.IsInFaction(faMinionState))
        Debug.Notification("You cannot improve free willed undead!")
        return false
    endif
    ;Needs Dark Ointment of Meridian to improve
    int iImprovementChoice =improveUndeadMssgList[0].Show()
    if iImprovementChoice == 0
        if (acActivator.GetItemCount(arRequiredComponents[0])>=1)
            improveUndeadMssgList[1].Show()
            acTarget.ModAV("health", 100)
            acTarget.ModAV("healrate", 5)
            acTarget.ModAV("combathealthregenmult", 0.20)
            acTarget.ModAV("healratemult", 100)
            acActivator.RemoveItem(arRequiredComponents[0], 1)
            return true
        else
            ;TODO replace with failure message list
            improveUndeadMssgList[2].Show()
            return false
        endif
    elseif iImprovementChoice == 1
        if (acActivator.GetItemCount(arRequiredComponents[1])>=1)
            improveUndeadMssgList[4].Show()
            acTarget.ModAV("magicka", 100)
            acTarget.ModAV("magickarate", 5)
            acTarget.ModAV("magickaratemult", 100)
            acActivator.RemoveItem(arRequiredComponents[1], 1)
            return true
        else
            improveUndeadMssgList[3].Show()
            return false
        endif
    elseif iImprovementChoice == 2
        if (acActivator.GetItemCount(arRequiredComponents[2])>=1  && acActivator.GetItemCount(arRequiredTools[0])>=1)
            improveUndeadMssgList[6].Show()
            acTarget.ModAV("stamina", 100)
            acTarget.ModAV("staminarate", 5)
            acTarget.ModAV("carryweight", 100)
            acTarget.ModAV("staminaratemult", 100)
            acActivator.RemoveItem(arRequiredComponents[2], 1)
            return true
        else
            improveUndeadMssgList[5].Show()
            return false
        endif
    elseif iImprovementChoice == 3
        if (acActivator.GetItemCount(arRequiredComponents[3])>=1)
            improveUndeadMssgList[8].Show()
            acTarget.SetAV("aggression", 2)
            acTarget.ModAV("speedmult", 100)
            acTarget.ModAV("weaponspeedmult", 1.20)
            acTarget.ModAV("leftweaponspeedmult", 1.20)
            acTarget.ModAV("unarmeddamage", 20)
            acTarget.ModAV("attackdamagemult", 0.20)
            acTarget.ModAV("bowstaggerbonus", 5)
            acActivator.RemoveItem(arRequiredComponents[3], 1)
            return true
        else
            improveUndeadMssgList[7].Show()
            return false
        endif
    elseif iImprovementChoice == 4
        if ((acActivator.GetItemCount(arRequiredComponents[4])>=1) && acActivator.GetItemCount(arRequiredTools[1])>=1 && acActivator.GetItemCount(arRequiredTools[2])>=1 && acActivator.GetItemCount(arRequiredTools[3])>=1 && acActivator.GetItemCount(arRequiredTools[4])>=1)
            improveUndeadMssgList[10].Show()
            acTarget.SetAV("assistance", 2)
            acTarget.ModAV("detectliferange", 100)
            acTarget.ModAV("onehanded", 25)
            acTarget.ModAV("twohanded", 25)
            acTarget.ModAV("blocking", 25)
            acTarget.ModAV("archery", 25)
            acTarget.ModAV("sneak", 25)
            acTarget.ModAV("critchance", 10)	
            acActivator.RemoveItem(arRequiredComponents[4], 1)
            return true
        else
            improveUndeadMssgList[11].Show()
            return false
        endif
    elseif iImprovementChoice == 5
        iUnforgivingHeartCount[0] = acActivator.GetItemCount(arRequiredComponents[5])
        iUnforgivingHeartCount[1] = acActivator.GetItemCount(arRequiredComponents[6])
        if (acActivator.GetItemCount(arRequiredTools[1])>=1 && acActivator.GetItemCount(arRequiredTools[2])>=1 && acActivator.GetItemCount(arRequiredTools[3])>=1 && acActivator.GetItemCount(arRequiredTools[4])>=1) && ((iUnforgivingHeartCount[0]>=1) || (iUnforgivingHeartCount[1]>=1))
            if (iUnforgivingHeartCount[0] > 0)
                acActivator.RemoveItem(arRequiredComponents[5], 1)
                blPlayerCheater = FALSE
            else
                acActivator.RemoveItem(arRequiredComponents[6], 1)
                blPlayerCheater = TRUE
            endif
            improveUndeadMssgList[14].Show()
            acTarget.GetLeveledActorBase().SetProtected(true)
            acTarget.ModAV("mass", 0.2)
            acTarget.ModAV("damageresist", 20)
            acTarget.ModAV("poisonresist", 20)
            acTarget.ModAV("fireresist", 20)
            acTarget.ModAV("frostresist", 20)
            acTarget.ModAV("electricresist", 20)
            acTarget.ModAV("magicresist", 20)
            ; Optionally call CheckForPunishment() here if needed
            return true
        else
            arRebukeUndeadMessageList[13].Show()
            return false
        endif
    endif
    ; Fallback: return false if no valid improvement choice was made
    return false
EndFunction

Function TryDestroy()
    int destructionChoiceIndex = YorN[0].Show()
    Debug.Notification("Attempting to destroy undead.")
    if !acTarget.IsInFaction(faMinionState)
        Debug.Notification("You cannot destroy free willed undead!")
        return
    elseif destructionChoiceIndex == 0
        if (acActivator.GetItemCount(arRequiredAllergens[0]) >= 1 && acActivator.GetItemCount(arRequiredTools[5]) >= 1)
            Debug.Notification("Destroying undead with fire.")
            destroyUndeadMessageList[2].Show()
            acTarget.Kill()
            acActivator.RemoveItem(arRequiredAllergens[0], 1)
        else
            Debug.Notification("You do not have the required items to destroy the undead.")
            destroyUndeadMessageList[1].Show()
        endif
    else
        ; if (acActivator.GetItemCount(arRequiredAllergens[1]) >= 1)
            destroyUndeadMessageList[0].Show()
        ;     acTarget.Disable()
        ;     acActivator.RemoveItem(arRequiredAllergens[1], 1)
    endif
EndFunction


Function ShowConfigureMenu()
    arRebukeUndeadMessageList[4].Show()
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

Function ShowRebukeMenu()
    int iPushedButton = arRebukeUndeadMessageList[0].Show()
    if iPushedButton == 0
        Debug.Notification("No option selected, exiting menu.")
        return
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
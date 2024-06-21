Scriptname VAoNMutatedHeartActivation extends ObjectReference  

import Actor

Event OnEquipped(Actor akActor)

acMutant = akActor

frmSelf = Self as Form

RegisterforUpdate(1.0)

endEvent


Event OnUpdated()

fCurrentMutantHealth = acMutant.GetActorValue("health")

if (fCurrentMutantHealth ==	fMinimumHealth)

    acMutant.UnequipItem(frmSelf , false, true)

elseif (fCurrentMutantHealth <	fMinimumHealth)
    acMutant.RestoreActorValue("health", (fMinimumHealth - fCurrentMutantHealth))
    acMutant.UnequipItem(frmSelf, false, true)

EndIf

endEvent

Event OnUnequipped(Actor akActor)

    UnregisterforUpdate()

endEvent

Actor Property acMutant  Auto  

Float Property fMinimumHealth  Auto  

Float Property fCurrentMutantHealth  Auto  

Form Property frmSelf  Auto  

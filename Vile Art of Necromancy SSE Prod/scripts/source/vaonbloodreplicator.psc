Scriptname VAoNBloodReplicator extends ObjectReference  

Potion Property ptNutrient  Auto  

Potion Property ptBlood  Auto  

import Actor

Event OnEquipped(Actor akActor)

acActor = akActor

orBloodReplicator = (Self as ObjectReference)

float fActivatorAlchemy = acActor.GetActorValue("alchemy")
float fActivatorAlteration = acActor.GetActorValue("alteration")

int iBloodUnits

If acActor.GetItemCount(ptBlood) > 0
 
    If acActor.GetItemCount(ptNutrient) > 0

    iBloodUnits = acActor.GetItemCount(ptNutrient)* ((fActivatorAlchemy * fActivatorAlteration) as int)

    acActor.RemoveItem(ptBlood, 1, true)
    acActor.RemoveItem(ptNutrient, 1, true)
    Debug.Notification("Blood is replicated from nutrients...")	
    acActor.AddItem(ptBlood, iBloodUnits)
    GotoState("BloodReplicatorUsed")
    Return

    else

    Debug.Notification("You need at least 1 unit of nutritive solution to replicate.")
    GotoState("BloodReplicatorUsed")
    Return
 
    endif


else

Debug.Notification("You need at least 1 unit of blood to replicate.")
GotoState("BloodReplicatorUsed")
Return

endif


EndEvent


State	BloodReplicatorUsed

Event OnBeginState()

acActor.UnequipItem(orBloodReplicator)

EndEvent

EndState

Actor Property acActor  Auto  



ObjectReference Property orBloodReplicator  Auto  

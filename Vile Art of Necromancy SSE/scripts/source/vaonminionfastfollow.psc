Scriptname VAoNMinionFastFollow extends activemagiceffect  

import Actor

import GlobalVariable

Event OnEffectStart(Actor akTarget, Actor akCaster)

float fFollowDelay

acMinion = akTarget

acPlayer = Game.GetPlayer()

fFollowDelay = glFollowDelay.GetValue()

RegisterForUpdate(fFollowDelay)

endEvent


Event OnUpdate() 		

If (glDeadAreCalled.GetValue() == 1)

    If  (acMinion.GetCombatState() == 1)

	 acMinion.StopCombat()

    EndIf

acMinion.MoveTo(acPlayer)

acMinion.PathToReference(acPlayer, 1.0)

EndIf

If (acMinion.HasLOS(acPlayer) == False)

acMinion.MoveTo(acPlayer)

Elseif  (acMinion.GetCombatState() == 0 )

acMinion.PathToReference(acPlayer, 1.0)

EndIf

EndEvent

Actor Property acMinion  Auto  

Actor Property acPlayer  Auto  

GlobalVariable Property glFollowDelay  Auto  

GlobalVariable Property glDeadAreCalled  Auto  

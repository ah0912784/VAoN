Scriptname VAoNMinionPutrefaction extends activemagiceffect  

import Actor

import GlobalVariable

Event OnEffectStart(Actor akTarget, Actor akCaster)

acMinion = akTarget

acPlayer = Game.GetPlayer()

float fPutrefactionTimer

fPutrefactionTimer = glPutrefactionTimer.GetValue()

RegisterForUpdate(fPutrefactionTimer)

endEvent


Event OnUpdate() 		

If (acMinion.HasLOS(acPlayer) == False)

spDeanimate.Cast(acMinion,acMinion)

EndIf

EndEvent


Actor Property acMinion  Auto  

Actor Property acPlayer  Auto  

SPELL Property spDeanimate  Auto  

GlobalVariable Property glPutrefactionTimer  Auto  

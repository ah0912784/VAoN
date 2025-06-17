Scriptname VAoNUndeadAutokill extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)

Utility.Wait(10)

akTarget.KillSilent()

Utility.Wait(10)

akTarget.Disable(true)

endEvent
Scriptname VAoNBecomeVampireThroughElixir extends activemagiceffect  

SPELL Property spDiseasePorphyricHemophelia  Auto  

Event OnEffectStart(Actor Target, Actor Caster)

	;there is a modified Porphyric Hemophelia with a 100% chance of getting it.
	If Target == Game.GetPlayer()
; 		debug.Trace(self + "Inducing Porphyric Hemophelia")
		Game.GetPlayer().DoCombatSpellApply(spDiseasePorphyricHemophelia, Game.GetPlayer())
	EndIf
	
EndEvent
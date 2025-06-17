Scriptname VAoNTearsOfOblivionScript extends activemagiceffect  

Perk Property prkTearofOblivion  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
  Debug.Trace("You feel the power of the Tear of Oblivion filling your soul with power...")
  akTarget.AddPerk(prkTearofOblivion)
endEvent


Event OnEffectEnd(Actor akTarget, Actor akCaster)
  Debug.Trace("You feel the power of the Tear of Oblivion leaving your soul...")
  akTarget.RemovePerk(prkTearofOblivion)
endEvent
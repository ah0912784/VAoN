Scriptname VAoNInstillSoulEssence extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)

 iISSInstanceRunning += 1

If ( iISSInstanceRunning == 1) 

acCorpse = akTarget
acCaster = akCaster

acCorpse.RemoveItem(ingComponent[0], 1, true)
acCorpse.RemoveItem(ingComponent[1], 1, true)
acCorpse.RemoveItem(moSkull[0], 1, true)
acCorpse.AddItem(moSkull[1], 1, true)
acCorpse.DropObject(moSkull[1], 1)
acCorpse.AddPerk(prkSoulHarvested)

EndIf

 iISSInstanceRunning = 0


endEvent

Ingredient[] Property ingComponent  Auto  

MiscObject[] Property moSkull  Auto  

Actor Property acCaster  Auto  

Actor Property acCorpse  Auto  

Perk Property prkSoulHarvested  Auto  

Int Property  iISSInstanceRunning  Auto  

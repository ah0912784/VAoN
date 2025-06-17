Scriptname VAoNInducedUndeadReset extends ObjectReference  

SPELL Property spResetSpell  Auto  

MiscObject Property moResetGem  Auto  

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

Actor acCaster = akOldContainer as Actor

Actor acUndeadToReset = akNewContainer as Actor

spResetSpell.Cast(acCaster, acUndeadToReset)

Utility.Wait(3)

int iGemNumber = acUndeadToReset.GetItemCount(moResetGem)

acUndeadToReset.RemoveItem(moResetGem, iGemNumber)

endEvent




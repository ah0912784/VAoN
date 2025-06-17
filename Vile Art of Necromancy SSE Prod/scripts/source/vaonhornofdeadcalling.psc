Scriptname VAoNHornOfDeadCalling extends ObjectReference  

import sound

import globalvariable

Event OnEquipped(Actor akActor)

acActivator = akActor

iHornIsInUse += 1

iHornBlowing = sdHornblowing.play(acActivator)    
Sound.SetInstanceVolume(iHornBlowing, 1.0)  
Debug.Notification("You are blowing the Horn of the Dead...")


If (iHornIsInUse == 1)

flOriginalUpdateTime = glMinionFollowUpdate.GetValue()

glCallingTheDead.SetValue(1)

glMinionFollowUpdate.SetValue(1.0)

EndIf

endEvent




Event OnUnequipped(Actor akActor)

iHornIsInUse = 0

glCallingTheDead.SetValue(0)

glMinionFollowUpdate.SetValue(flOriginalUpdateTime)

Sound.StopInstance(iHornBlowing) 

endEvent


GlobalVariable Property glCallingTheDead  Auto  

Float Property flOriginalUpdateTime  Auto  

Sound Property sdHornblowing  Auto  

Actor Property acActivator  Auto  

Int Property iHornBlowing  Auto  

GlobalVariable Property glMinionFollowUpdate  Auto  

Int Property iHornIsInUse  Auto  

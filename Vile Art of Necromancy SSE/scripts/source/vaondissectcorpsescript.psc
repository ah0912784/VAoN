Scriptname VAoNDissectCorpseScript extends activemagiceffect  
{This script manages the dissection of humanoid corpses.}

import activator
import actorbase

MiscObject[] Property arCorpseMiscBodyParts  Auto  

Ingredient[] Property arEdibleBodyParts  Auto  

Potion[] Property arEdibleSubstance  Auto  

Ingredient[] Property arAlternateEye  Auto  

Ingredient[] Property arAlternateFat  Auto  

Ingredient[] Property arAlternateFlesh  Auto  

MiscObject[] Property arAlternateSkin  Auto  

Race[] Property arBeastRace  Auto  

Activator Property acBloodPuddle  Auto  

ObjectReference Property orVictimAshpile  Auto  

GlobalVariable Property glOrderlyDissection  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)

Game.ForceThirdPerson()

Game.GetPlayer().StartCannibal(akTarget)

Game.ShakeCamera(afStrength = 0.2, afDuration = 2.0)
akTarget.SetCriticalStage(1) 
;akTarget.Disable(true)

int iDissectionOption = glOrderlyDissection.GetValue() as int
float plyrOneHanded = Game.GetPlayer().GetActorValue("onehanded") as float
float plyrAlchemy = Game.GetPlayer().GetActorValue("alchemy") as float
float iPlayerDissectionSkill = (plyrAlchemy + plyrOneHanded) / 2

int iPlayerDissectionResult = iPlayerDissectionSkill as int

if iPlayerDissectionResult > 100
   iPlayerDissectionResult = 100
elseif iPlayerDissectionResult < 1
   iPlayerDissectionResult = 1
endif

if (akTarget.GetLeveledActorBase().GetRace() == arBeastRace[0]) || (akTarget.GetLeveledActorBase().GetRace() == arBeastRace[1])

   arCorpseMiscBodyParts[11] =  arAlternateSkin[0]
   arEdibleBodyParts[1] =   arAlternateFlesh[0]
   arEdibleBodyParts[2] =   arAlternateEye[0]
   arEdibleBodyParts[3] =   arAlternateFat[0]

elseif (akTarget.GetLeveledActorBase().GetRace() == arBeastRace[2]) || (akTarget.GetLeveledActorBase().GetRace() == arBeastRace[3])

   arCorpseMiscBodyParts[11] =  arAlternateSkin[1]
   arEdibleBodyParts[1] =   arAlternateFlesh[1]
   arEdibleBodyParts[2] =   arAlternateEye[1]
   arEdibleBodyParts[3] =   arAlternateFat[1]

endif


int iHarvestedMeat = ((48 * iPlayerDissectionResult)/100) as int
int iHarvestedFat = ((30 * iPlayerDissectionResult)/100) as int
int iHarvestedBlood = ((100 * iPlayerDissectionResult)/100) as int


Debug.Notification("You finished the dissection.")

Game.ShakeCamera(afStrength = 0.2, afDuration = 3.0)

akTarget.AttachAshPile(acBloodPuddle)
akTarget.SetCriticalStage(2)
orVictimAshpile = Game.FindClosestReferenceOfType(acBloodPuddle, 0.0, 0.0, 0.0, 256)

int i = 0
int n = arCorpseMiscBodyParts.Length

While i < n
   akTarget.addItem(arCorpseMiscBodyParts[i], 1, true)

   i = i + 1
EndWhile

addMiscBodyPart(true, akTarget, arEdibleBodyParts,arEdibleSubstance, iHarvestedBlood, iHarvestedFat, iHarvestedMeat)


; orVictimAshpile.addItem(arEdibleBodyParts[0], 1, true)
; orVictimAshpile.addItem(arEdibleBodyParts[1], iHarvestedMeat, true)
; orVictimAshpile.addItem(arEdibleBodyParts[2], 2, true)
; orVictimAshpile.addItem(arEdibleBodyParts[3], iHarvestedFat, true)
; orVictimAshpile.addItem(arEdibleSubstance[0], iHarvestedBlood, true)


; akCaster.DropObject(arCorpseMiscBodyParts[0], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[1], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[2], 2)
; akCaster.DropObject(arCorpseMiscBodyParts[3], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[4], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[5], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[6], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[7], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[8], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[9], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[10], 1)
; akCaster.DropObject(arCorpseMiscBodyParts[11], 1)
; akCaster.DropObject(arEdibleBodyParts[0], 1)
; akCaster.DropObject(arEdibleBodyParts[1], iHarvestedMeat)
; akCaster.DropObject(arEdibleBodyParts[2], 2)
; akCaster.DropObject(arEdibleBodyParts[3], iHarvestedFat)
; akCaster.DropObject(arEdibleSubstance[0], iHarvestedBlood)

if (iDissectionOption == 0)


   While i < n
      akTarget.DropObject(arCorpseMiscBodyParts[i], 1)
      i = i + 1
   EndWhile
   addMiscBodyPart(false, akTarget, arEdibleBodyParts,arEdibleSubstance, iHarvestedBlood, iHarvestedFat, iHarvestedMeat)


else

Debug.Notification("The dissection is complete; now gather what you need from what remain of the corpse.")

endif

; akTarget.RemoveAllItems(orVictimAshpile)

Game.EnablePlayerControls(true, true, true, true, true, true, true, true, 0)

RegisterForSingleLOSLost(Game.GetPlayer(), akTarget) 

EndEvent

State WaitForLostLOS

Event OnLostLOS(Actor akViewer, ObjectReference akTarget)

    akTarget.DeleteWhenAble() 

    orVictimAshpile.DeleteWhenAble()     

endEvent

endState


Function addMiscBodyPart(bool add, Actor akTarget, Ingredient[] arEdibleBodyParts, Potion[] arEdibleSubstance, int iHarvestedBlood, int iHarvestedFat, int iHarvestedMeat)
   if add
      akTarget.AddItem(arEdibleBodyParts[0],1,false) ;Heart
      akTarget.AddItem(arEdibleBodyParts[1],iHarvestedMeat,false) ;Flesh
      akTarget.addItem(arEdibleBodyParts[2], 2, false) ;Eyes
      akTarget.AddItem(arEdibleBodyParts[3], iHarvestedFat,false)
      akTarget.AddItem(arEdibleSubstance[0], iHarvestedBlood, false)
   else
      akTarget.DropObject(arEdibleBodyParts[0],1) ;Heart
      akTarget.DropObject(arEdibleBodyParts[1],iHarvestedMeat) ;Flesh
      akTarget.DropObject(arEdibleBodyParts[2],2) ;Eyes
      akTarget.DropObject(arEdibleBodyParts[3],iHarvestedFat)
      akTarget.DropObject(arEdibleSubstance[0],iHarvestedBlood)
   endif
EndFunction

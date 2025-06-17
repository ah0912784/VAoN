Scriptname VAoNExtractSpiritEssence extends activemagiceffect

import math  

Event OnEffectStart(Actor akTarget, Actor akCaster)

iExSpiInstanceRunning += 1


If (iExSpiInstanceRunning == 1)

acCorpse = akTarget
acCaster = akCaster
iCorpseLevel = acCorpse.GetLevel()
iCasterLevel = acCaster.GetLevel()


If (iCorpseLevel < iCasterLevel)

flPowerFactor = 0.25

elseif (iCorpseLevel == iCasterLevel)

flPowerFactor = 0.50

elseif  (iCorpseLevel > iCasterLevel)

flPowerFactor = 1.00

EndIf


int iCount = 0

While (iCount <  strStatisticLabel.Length)

flCasterStatistic[iCount] = acCaster.GetBaseActorValue(strStatisticLabel[iCount]) as float
flCorpseStatistic[iCount] = acCorpse.GetBaseActorValue(strStatisticLabel[iCount]) as float

iCount += 1

EndWhile

flCasterElementalSpirit[0] = flCasterStatistic[7] + flCasterStatistic[8] + flCasterStatistic[11]
flCasterElementalSpirit[1] = flCasterStatistic[2] 
flCasterElementalSpirit[2] = flCasterStatistic[12] + flCasterStatistic[13] + flCasterStatistic[15]
flCasterElementalSpirit[3] = flCasterStatistic[5] + flCasterStatistic[14] + flCasterStatistic[17]
flCasterElementalSpirit[4] = flCasterStatistic[4] + flCasterStatistic[9] + flCasterStatistic[16]
flCasterElementalSpirit[5] = flCasterStatistic[0] 
flCasterElementalSpirit[6] = flCasterStatistic[3] + flCasterStatistic[18] + flCasterStatistic[19]
flCasterElementalSpirit[7] = flCasterStatistic[1] 
flCasterElementalSpirit[8] = flCasterStatistic[6] + flCasterStatistic[10] + flCasterStatistic[20]

flCorpseElementalSpirit[0] = flCorpseStatistic[7] + flCorpseStatistic[8] + flCorpseStatistic[11]
flCorpseElementalSpirit[1] = flCorpseStatistic[2] 
flCorpseElementalSpirit[2] = flCorpseStatistic[12] + flCorpseStatistic[13] + flCorpseStatistic[15]
flCorpseElementalSpirit[3] = flCorpseStatistic[5] + flCorpseStatistic[14] + flCorpseStatistic[17]
flCorpseElementalSpirit[4] = flCorpseStatistic[4] + flCorpseStatistic[9] + flCorpseStatistic[16]
flCorpseElementalSpirit[5] = flCorpseStatistic[0] 
flCorpseElementalSpirit[6] = flCorpseStatistic[3] + flCorpseStatistic[18] + flCorpseStatistic[19]
flCorpseElementalSpirit[7] = flCorpseStatistic[1] 
flCorpseElementalSpirit[8] = flCorpseStatistic[6] + flCorpseStatistic[10] + flCorpseStatistic[20]

flHighestElementalScore = 0
iHighestElementalSpirit = 0
iCount = 0

While (iCount <  strElementalSpiritName.Length)

if (flCorpseElementalSpirit[iCount] >= flHighestElementalScore)

iHighestElementalSpirit = iCount

flHighestElementalScore = flCorpseElementalSpirit[iCount]

EndIf

iCount += 1

EndWhile

iCount = 0

Debug.Notification("You feel that " + strElementalSpiritName[iHighestElementalSpirit] + " is the strongest elemental spirit in this creature.")

While (iCount <  flCorpseElementalSpirit.Length)

if (flCorpseElementalSpirit[iCount] >= flCasterElementalSpirit[iCount])

iExtractedUnits[iCount] = floor((flCorpseElementalSpirit[iCount] - flCasterElementalSpirit[iCount]) * flPowerFactor * 100)

else

iExtractedUnits[iCount] = floor(((flCorpseElementalSpirit[iCount] - 1)/flCasterElementalSpirit[iCount]) * flPowerFactor * 100) 

EndIf

If ((floor((iCasterLevel  as float)/2) > 1) && (iExtractedUnits[iCount] < (floor((iCasterLevel  as float)/2))))

iExtractedUnits[iCount] = floor((iCasterLevel  as float)/2)

elseif ((floor((iCasterLevel  as float)/2) < 1) && (iExtractedUnits[iCount] < 1))

iExtractedUnits[iCount] = 1

EndIf

iCount += 1

EndWhile

iCount = 0


GoToState("ChooseElementalSpirit")

Return

EndIf

endEvent


State ChooseElementalSpirit

Event OnBeginState()

int iButtonPushed

iButtonPushed = msgExtractSpiritEssenceMenu[0].Show()

Debug.Notification(iExtractedUnits[iButtonPushed] + " " + strElementalSpiritName[iButtonPushed] + " essence units would be extracted.")

intChosenEssenceSpirit = iButtonPushed

GoToState("ConfirmChoice")

Return

EndEvent

EndState



State ConfirmChoice

Event OnBeginState()

int iButtonPushed

iButtonPushed = msgExtractSpiritEssenceMenu[1].Show()

if (iButtonPushed == 0)

GoToState("ExtractEssence")
Return

elseif (iButtonPushed == 1)

GoToState("ChooseElementalSpirit")
Return

EndIf

EndEvent

EndState


State ExtractEssence

Event OnBeginState()

acCorpse.RemoveItem(ptBlood, 1, true)
acCorpse.RemoveItem(ingSoulgemPowder, 1, true)
acCorpse.AddItem(ingEssence[intChosenEssenceSpirit], iExtractedUnits[intChosenEssenceSpirit], true)
acCorpse.AddPerk(prkSoulHarvested)
Debug.Notification("You extract the creature's spirit and coalesce it into the chosen essence...")
GoToState("FinishExtraction")
Return

EndEvent

EndState


State FinishExtraction

Event OnBeginState()

iExSpiInstanceRunning = 0

EndEvent

EndState



Actor Property acCaster  Auto  

Actor Property acCorpse  Auto  

String[] Property strStatisticLabel  Auto  

Ingredient[] Property ingEssence  Auto  

Int[] Property iExtractedUnits  Auto  

Float[] Property flCasterStatistic  Auto  

Float[] Property flCorpseStatistic  Auto  

Perk Property prkSoulHarvested  Auto  

Potion Property ptBlood  Auto  

Ingredient Property ingSoulgemPowder  Auto  

Float[] Property flCasterElementalSpirit  Auto  

Float[] Property flCorpseElementalSpirit  Auto  

String[] Property strElementalSpiritName  Auto  

Float Property flHighestElementalScore  Auto  

Int Property iHighestElementalSpirit  Auto  

Message[] Property msgExtractSpiritEssenceMenu  Auto  

Int Property intChosenEssenceSpirit  Auto  

Int Property iCasterLevel  Auto  

Int Property iCorpseLevel  Auto  

Float Property flPowerFactor  Auto  

Int Property iExSpiInstanceRunning  Auto  

Int Property iChangeRatio  Auto  

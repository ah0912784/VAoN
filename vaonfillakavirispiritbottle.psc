Scriptname VAoNFillAkaviriSpiritBottle extends ObjectReference  
{This script allows to store a single Dragon Soul into a spirit bottle.}

import actor
Message    Property msgSpiritBottleActivation    Auto  
MiscObject Property moFilledSpiritBottle         Auto  
MiscObject Property VAoNAkiviriSpiritBottleEmpty Auto
Actor      Property PlayerREF = None             Auto 
Event OnEquipped(Actor akActor)
 
  if akActor == PlayerREF
    addDragonSoul(msgSpiritBottleActivation, moFilledSpiritBottle,VAoNAkiviriSpiritBottleEmpty, akActor)

  Else
    ;do nothing
  EndIf
EndEvent

Function addDragonSoul(Message msgSpiritBottle, MiscObject filledSpiritBottle,MiscObject emptySpiritBottle, Actor akActor )

  int dragonSoulCount = akActor.GetActorValue("dragonSouls") as int
  int iSelection
  iSelection = msgSpiritBottle.Show()

    if (iSelection == 0 && dragonSoulCount > 0)

      Game.GetPlayer().ModAV("dragonSouls", -1)  
      akActor.RemoveItem(emptySpiritBottle, 1, True)
      akActor.AddItem(filledSpiritBottle, 1, true)
 
      Debug.Notification("You have filled the spirit bottle with the last breath of a dragon...")

    ElseIf (dragonSoulCount < 1 )
      Debug.Notification("To do this you need to have a dragon soul first")
      ; code

    Else
      ;do nothing and move to end event handles the contra positive case
    endif
EndFunction
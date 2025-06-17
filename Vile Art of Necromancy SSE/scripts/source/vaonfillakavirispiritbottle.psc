Scriptname VAoNFillAkaviriSpiritBottle extends ObjectReference  
{This script allows to store a single Dragon Soul into a spirit bottle.}

import actor

Message Property msgSpiritBottleActivation  Auto  

MiscObject Property moFilledSpiritBottle  Auto  


Event OnActivate(ObjectReference akActionRef)

int iSelection

   if akActionRef == Game.GetPlayer()

     iSelection = msgSpiritBottleActivation.Show()

    if iSelection == 0
      
      Game.GetPlayer().ModAV("dragonSouls", -1)  

      Self.Disable()

      akActionRef.AddItem(moFilledSpiritBottle, 1, true)
 
      Debug.Notification("You have filled the spirit bottle with the last breath of a dragon...")

    else
     
     akActionRef.AddItem(Self, 1, false)

    endif
  
 endif

EndEvent

Scriptname VAoNActivateDaedricMysteryBox extends ObjectReference  

import GlobalVariable

Event OnInit() 

	Self.BlockActivation()

EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

		Self.BlockActivation()

EndEvent

Event OnActivate(ObjectReference akActionRef)

	acActivator = akActionRef as Actor

	 intActivatorSpeechcraft = (acActivator.GetActorValue("speechcraft") as int)

	iCurrentSoulEnergy =  (glSoulEnergy.GetValue() as int)
	intHeartSacrificed = (glHumanHeartSacrifice.GetValue() as int)
	intDaedricCoinsSacrificed = (glDaedricCoinSacrifice.GetValue() as int)
	intActivatorKilledPersons = Game.QueryStat("People Killed")
	intActivatorMurders = Game.QueryStat("Murders")

      GotoState("ActivationMenu")
      Return


EndEvent


State ActivationMenu

Event OnBeginState()

	int iPushedButton

	iPushedButton = msgDaedricBoxMenu[0].Show()

	if iPushedButton == 0
	   GotoState("BoxActivated")
	   Return
	elseif iPushedButton == 1
	   acActivator.AddItem(Self, 1)
	   GotoState("BoxClosed")
	   Return
	elseif iPushedButton == 2
	   GotoState("ChargeBox")
	   Return  
	elseif iPushedButton == 3
	   GotoState("OfferSacrifice")
	   Return 	
	elseif iPushedButton == 4
	   acActivator.AddItem(bkInstructions, 1)
	   GotoState("BoxClosed")
	   Return
	elseif iPushedButton == 5
	   GotoState("Configure")
	   Return 	
	elseif iPushedButton == 6
	   GotoState("TradeEssence")
	   Return 
	Endif

EndEvent

EndState


State BoxActivated

Event OnBeginState()

	int iPushedButton
	int iCharacterLevel = acActivator.GetLevel()

	intHeartSacrificed = (glHumanHeartSacrifice.GetValue() as int)
	intDaedricCoinsSacrificed = (glDaedricCoinSacrifice.GetValue() as int)
       intOblivionFavor = ((intDaedricCoinsSacrificed * 100) + (intHeartSacrificed * 1000) + (intActivatorKilledPersons * 5) + (intActivatorMurders * 10))/iCharacterLevel as int
	int intWealth

       If  iWealthFactor == 0
           iWealthFactor = 100
      endif

	If iCurrentSoulEnergy == 0
	  Debug.Notification("The box has no soul energy.") 
	  Debug.Notification("Recharge it with soul gems.")
         GotoState("ActivationMenu")
	   Return
      else
     	  Debug.Notification("Your current Oblivion Favor is " + intOblivionFavor ) 
	
	   iPushedButton = msgDaedricBoxMenu[3].Show()	
         if iPushedButton == 0
            if ((acActivator.GetItemCount(moMiscellaneousObject[0])== 0) && (intDaedricCoinsSacrificed == 0))
		  Debug.Notification("This service require at least 1 daedric coin as payment.")   
            else
		  Debug.Notification("The Daedra Princes fill your soul with dragon spirit...")   
		  intWealth = ((intOblivionFavor/(iWealthFactor*10)) as int)
		  acActivator.ModActorValue("DragonSouls", intWealth)
		  iCurrentSoulEnergy-=1
                glSoulEnergy.SetValue(iCurrentSoulEnergy)
		  if 	(intDaedricCoinsSacrificed == 0)	   
			acActivator.RemoveItem(moMiscellaneousObject[0], 1)
		  endif
	        glHumanHeartSacrifice.SetValue(0)	
               glDaedricCoinSacrifice.SetValue(0)
	         GotoState("BoxClosed")
		   Return
		endif	

	  elseif iPushedButton == 1
            if ((acActivator.GetItemCount(moMiscellaneousObject[0])== 0) && (intDaedricCoinsSacrificed == 0))
		  Debug.Notification("This service require at least 1 daedric coin as payment.")   
            else
		  intWealth =  ((intOblivionFavor * intActivatorSpeechcraft)/(iWealthFactor*100)) as int
		  Debug.Notification("The Daedra Princes grants you powerful artifacts...")   
	         acActivator.AddItem(ptOblivionTear,  intWealth)
		  iCurrentSoulEnergy-=1
               glSoulEnergy.SetValue(iCurrentSoulEnergy)
		  if 	(intDaedricCoinsSacrificed == 0)	   
			acActivator.RemoveItem(moMiscellaneousObject[0], 1)
		  endif
	        glHumanHeartSacrifice.SetValue(0)	
               glDaedricCoinSacrifice.SetValue(0)
	         GotoState("BoxClosed")
		   Return
		endif

	  elseif iPushedButton == 2
            if ((acActivator.GetItemCount(moMiscellaneousObject[0])== 0) && (intDaedricCoinsSacrificed == 0))
		  Debug.Notification("This service require at least 1 daedric coin as payment.")   
            else
		  intWealth =  ((intOblivionFavor * intActivatorSpeechcraft * 10)/iWealthFactor) as int
		  Debug.Notification("The Daedra Princes fill your pockets with gold...")   
	         acActivator.AddItem(moMiscellaneousObject[1],  intWealth)
		  iCurrentSoulEnergy-=1
               glSoulEnergy.SetValue(iCurrentSoulEnergy)
		  if 	(intDaedricCoinsSacrificed == 0)	   
			acActivator.RemoveItem(moMiscellaneousObject[0], 1)
		  endif
	        glHumanHeartSacrifice.SetValue(0)	
               glDaedricCoinSacrifice.SetValue(0)
	         GotoState("BoxClosed")
		   Return		
		endif
         elseif iPushedButton == 3 
         GotoState("ActivationMenu")
	   Return
	  endif
      endif       


EndEvent

EndState


State ChargeBox

Event OnBeginState()

	Debug.Notification("The soul energy of the box is of " + iCurrentSoulEnergy + " units.")

	int iPushedButton

       iPushedButton = msgDaedricBoxMenu[1].Show()	
	if (iPushedButton == 6)
         GotoState("ActivationMenu")
	   Return
      else

		if (acActivator.GetItemCount(sgSoulGems[iPushedButton]) == 0)
		   Debug.Notification("You don't have a filled soul gem of that size.")
	   	   Debug.Notification("Retry...")
	         GotoState("ChargeBox")
		   Return
	       else
		   iCurrentSoulEnergy+= intSoulEnergyContent[iPushedButton]
		   acActivator.RemoveItem(sgSoulGems[iPushedButton], 1)
		   glSoulEnergy.SetValue(iCurrentSoulEnergy)
	          Debug.Notification("The soul energy of the box is of " + iCurrentSoulEnergy + " units.")
		   GotoState("ActivationMenu")
		   Return   
		endif
	endif

EndEvent

EndState

State OfferSacrifice

Event OnBeginState()

	int iPushedButton
	int iOffer

	Debug.Notification("You have sacrificed " +  intHeartSacrificed + " human hearts and " +intDaedricCoinsSacrificed + " daedric coins." )

       iPushedButton = msgDaedricBoxMenu[2].Show()	

	if iPushedButton == 0
	      iOffer = acActivator.GetItemCount(ingHeart)
		if (iOffer == 0)
		   Debug.Notification("You don't have human hearts to sacrifice...")
		   Debug.Notification("Retry...")
       	  GotoState("OfferSacrifice")
		   Return
       	else
		   Debug.Notification("You have sacrificed " + iOffer + " human hearts.")
		   acActivator.RemoveItem(ingHeart, iOffer)
		   intHeartSacrificed += iOffer
		   iOffer = 0
	          glHumanHeartSacrifice.SetValue(intHeartSacrificed)		 
		endif
        elseif  iPushedButton == 1
	      iOffer = acActivator.GetItemCount(moMiscellaneousObject[0])
		if (iOffer == 0)
		   Debug.Notification("You don't have daedric coins to sacrifice...")
		   Debug.Notification("Retry...")
       	  GotoState("OfferSacrifice")
		   Return
       	else
		   Debug.Notification("You have sacrificed " + iOffer + " daedric coins.")
		   acActivator.RemoveItem(moMiscellaneousObject[0], iOffer)
		   intDaedricCoinsSacrificed += iOffer
		   iOffer = 0
	          glDaedricCoinSacrifice.SetValue(intDaedricCoinsSacrificed)		 
		endif
        elseif  iPushedButton == 2
	   GotoState("ActivationMenu")
	   Return   
	endif


EndEvent

EndState

State Configure

Event OnBeginState()

	int iPushedButton

	Debug.Notification("The current wealth factor is " + iWealthFactor)

       iPushedButton = msgDaedricBoxMenu[4].Show()	
	 iWealthFactor = iWealthOptions[iPushedButton]	

	Debug.Notification("The wealth factor changed to " + iWealthFactor)
    
       GotoState("ActivationMenu")
	Return   

EndEvent

EndState

State TradeEssence

Event OnBeginState()

iTradeInEssence = msgDaedricBoxMenu[5].Show()	

If (iTradeInEssence == 9)

       GotoState("ActivationMenu")
	Return   

else

	iTradeOutEssence = msgDaedricBoxMenu[6].Show()	
	iTradedUnits = acActivator.GetItemCount(ingEssence[iTradeInEssence])
	acActivator.RemoveItem(ingEssence[iTradeInEssence], iTradedUnits, true)
	acActivator.AddItem(ingEssence[iTradeOutEssence], iTradedUnits, true)
	Debug.MessageBox("You have traded " + iTradedUnits + " units of " +  strEssenceLabel[iTradeInEssence] + " for the same amount of " + strEssenceLabel[iTradeOutEssence])
       iCurrentSoulEnergy-=1
       glSoulEnergy.SetValue(iCurrentSoulEnergy)
	 if (intDaedricCoinsSacrificed == 0)	   
	     acActivator.RemoveItem(moMiscellaneousObject[0], 1)
	endif
       GotoState(" BoxClosed")
	Return   

EndIf




EndEvent

EndState


State BoxClosed

EndState

SoulGem[] Property sgSoulGems  Auto  

GlobalVariable Property glSoulEnergy  Auto  

GlobalVariable Property glDaedricCoinSacrifice  Auto  

GlobalVariable Property glHumanHeartSacrifice  Auto  

Int Property iCurrentSoulEnergy  Auto  

 

Message[] Property msgDaedricBoxMenu  Auto  

Book Property bkInstructions  Auto  



Int Property intActivatorSpeechcraft  Auto  

Int Property intActivatorKilledPersons  Auto  

Int Property intActivatorMurders  Auto  

Int Property intOblivionFavor  Auto  

Int Property intHeartSacrificed  Auto  

Int Property intDaedricCoinsSacrificed  Auto  

Actor Property acActivator  Auto  

MiscObject[] Property moMiscellaneousObject  Auto  

Potion Property ptOblivionTear  Auto  

Int[] Property intSoulEnergyContent  Auto  

Ingredient Property ingHeart  Auto  

Int Property iWealthFactor  Auto  

Int[] Property iWealthOptions  Auto  

String[] Property strEssenceLabel  Auto  

Ingredient[] Property ingEssence  Auto  

Int Property iTradeInEssence  Auto  

Int Property iTradeOutEssence  Auto  

Int Property iTradedUnits  Auto  

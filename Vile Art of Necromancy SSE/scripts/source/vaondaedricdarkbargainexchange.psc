Scriptname VAoNDaedricDarkBargainExchange extends ActiveMagicEffect  

Int Property iCasterSoulPotence  Auto  

Int Property iVictimSoulPotence  Auto  

Actor Property acActivator  Auto  

Actor Property acTarget  Auto  

Float Property fVictimSpeed  Auto  

Keyword[] Property arSpecialTypes  Auto  

Float Property fSpecialPriceMultiplier  Auto  

Float[] Property fVictimMorality  Auto  

MiscObject Property moDeadricCoins  Auto  

Float[] Property fSpecialTypePriceMultiplier  Auto  

Keyword Property kyForbiddenRace  Auto  


Event OnEffectStart(Actor akTarget, Actor akCaster)

acActivator = akCaster

acTarget = akTarget

iCasterSoulPotence = (acActivator.GetActorValue("magicka") as int) + (acActivator.GetActorValue("conjuration") as int) + (acActivator.GetActorValue("speechcraft") as int) + ((acActivator.GetActorValue("dragonsouls") as int) *10) + (acActivator.GetLevel())

iVictimSoulPotence = (acTarget.GetActorValue("magicka") as int) + (acTarget.GetActorValue("speechcraft") as int) + (((acTarget.GetActorValue("aggression") as int) + (acTarget.GetActorValue("confidence") as int)+ (acTarget.GetActorValue("assistance") as int))*10) + (acTarget.GetLevel())

iCasterSoulPotence += Utility.RandomInt(-10, 10)

iVictimSoulPotence += Utility.RandomInt(-10, 10)

if ((iCasterSoulPotence > iVictimSoulPotence) || (blTestingEffect == TRUE))

	Debug.Notification("The Deadric Princes have listened your offer...")
      fVictimSpeed = acTarget.GetAV("speedmult")				 
	acTarget.SetAlpha(0.2, true)
	acTarget.DamageActorValue("speedmult", -fVictimSpeed)
	 fVictimMorality[0] = acTarget.GetAV("morality")
	 fVictimMorality[1] = acTarget.GetAV("aggression")
	 fVictimMorality[2] = acTarget.GetAV("assistance")

	 fSpecialPriceMultiplier = ((fVictimMorality[0] + 1) * (4-fVictimMorality[1]) * (fVictimMorality[2] + 1))
	
	acTarget.SetRestrained(true)
	if acTarget.GetLeveledActorBase().IsEssential()

	        acTarget.GetLeveledActorBase().SetEssential(false)

	endif
	if acTarget.GetLeveledActorBase().IsInvulnerable()

	     acTarget.GetLeveledActorBase().SetInvulnerable(false)

	endif
       if acTarget.GetLeveledActorBase().IsProtected()

		acTarget.GetLeveledActorBase().SetProtected(false)

	endif

	GotoState("VictimFading")
      Return

else

	Debug.Notification("The Deadric Princes are disappointed by your weakness...")
	GotoState("CasterPunished")
      Return

endif

Endevent

State VictimFading

Event OnBeginState()

	int iCounter
	int iCoinAmount = 0
	string stPlural 
	int iArrayIndex = arSpecialTypes.Length

	if acTarget.HasKeyword( kyForbiddenRace)
		
        	GotoState("AngryDeadricPrinces")
             Return
	
	endif

	acTarget.SetActorValue("confidence", 4)

	acTarget.EvaluatePackage()

	acTarget.SetAlpha(0.4, true)

	While (iCounter < (iArrayIndex))

		if acTarget.HasKeyword(arSpecialTypes[iCounter])

       	fSpecialPriceMultiplier +=fSpecialTypePriceMultiplier[iCounter]

		endif
	
	iCounter += 1

	EndWhile	

	Debug.Notification("...they are granting your victim's possession...")

	acTarget.RemoveAllItems(akTransferTo = acActivator, abRemoveQuestItems = true)

	acTarget.SetAlpha(0.6, true)

	float fVictimSoulPotence = (iVictimSoulPotence as float)

	iCoinAmount = ((fVictimSoulPotence* fSpecialPriceMultiplier) as int)/100

	Debug.Notification("...and paying you the price of the victim's soul...")

	if iCoinAmount > 1
	   stPlural = "s"
	else
	   stPlural = ""
	endif

	acTarget.SetAlpha(0.8, true)
	acTarget.KillSilent(acActivator)

	Debug.Notification("...which is " + iCoinAmount + " deadric coin" + stPlural + "!")

	acActivator.Additem(moDeadricCoins,iCoinAmount)
	acTarget.Disable(true)
	acTarget.DeleteWhenAble()
	GotoState("FinishSpell")
      Return

EndEvent

EndState

State CasterPunished

Event OnBeginState()

	Debug.Notification("...and now...SUFFER, SLAVE!")
	float fSpeedReduction = (acActivator.GetActorValue("speedmult"))*(3/4)

	float fWaitTime = ((iVictimSoulPotence - iCasterSoulPotence)/iCasterSoulPotence) as float

	if fWaitTime > 24.0
	   fWaitTime = 24.0
	endif

	acActivator.DamageActorValue("health", -((acActivator.GetActorValue("health") - 5)))
	acActivator.DamageActorValue("magicka", -((acActivator.GetActorValue("magicka") - 5)))
	acActivator.DamageActorValue("stamina", -((acActivator.GetActorValue("stamina") - 5)))
	acActivator.DamageActorValue("speedmult",  -fSpeedReduction)
	Utility.WaitGameTime(fWaitTime)
	acActivator.RestoreActorValue("speedmult",  fSpeedReduction)
	GotoState("FinishSpell")
      Return

EndEvent

EndState


State AngryDeadricPrinces

Event OnBeginState()

	Debug.Notification("...and disliked the way you treat the Daedra!")
	Debug.Notification("Now die...with the *blessing* of the Daedric Princes!")
	acTarget.SetAlpha(0.0)
	acTarget.RestoreActorValue("speedmult", fVictimSpeed)
	acTarget.ModAV("speedmult", fVictimSpeed)
       acTarget.ModAV("health", 100)
       acTarget.ModAV("healrate", 5)
       acTarget.ModAV("combathealthregenmult", 0.20)
       acTarget.ModAV("healratemult", 100)
       acTarget.ModAV("magicka", 100)
      acTarget.ModAV("magickarate", 5)
       acTarget.ModAV("magickaratemult", 100)
       acTarget.ModAV("stamina", 100)
       acTarget.ModAV("staminarate", 5)
       acTarget.ModAV("carryweight", 100)
       acTarget.ModAV("staminaratemult", 100)
        acTarget.ModAV("weaponspeedmult", 1.20)
        acTarget.ModAV("leftweaponspeedmult", 1.20)
        acTarget.ModAV("unarmeddamage", 20)
        acTarget.ModAV("attackdamagemult", 0.20)
        acTarget.ModAV("critchance", 10)	
        acTarget.GetLeveledActorBase().SetProtected(true)
        acTarget.EvaluatePackage()
        acTarget.StartCombat(acActivator)
	GotoState("FinishSpell")
      Return

EndEvent

EndState


State FinishSpell

Event OnBeginState()

EndEvent

EndState







Bool Property blTestingEffect  Auto  

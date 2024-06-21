Scriptname VAoNBlasphemousResurrection extends activemagiceffect  

Int Property iCasterSoulPotence  Auto  

Int Property iVictimSoulPotence  Auto  

Actor Property acActivator  Auto  

Actor Property acTarget  Auto  

Bool Property blTestingEffect  Auto  

Float Property fVictimSpeed  Auto  

float fWaitTime 

Event OnEffectStart(Actor akTarget, Actor akCaster)

acActivator = akCaster

acTarget = akTarget

iCasterSoulPotence = (acActivator.GetActorValue("magicka") as int) + (acActivator.GetActorValue("conjuration") as int) + (acActivator.GetActorValue("speechcraft") as int) + ((acActivator.GetActorValue("dragonsouls") as int) *10) + (acActivator.GetLevel())

iVictimSoulPotence = (acTarget.GetActorValue("magicka") as int) + (acTarget.GetActorValue("speechcraft") as int) + (((acTarget.GetActorValue("aggression") as int) + (acTarget.GetActorValue("confidence") as int)+ (acTarget.GetActorValue("assistance") as int))*10) + (acTarget.GetLevel())

iCasterSoulPotence += Utility.RandomInt(-10, 10)

iVictimSoulPotence += Utility.RandomInt(-10, 10)

if ((iCasterSoulPotence > iVictimSoulPotence) || (blTestingEffect == FALSE))

   fWaitTime = ((iVictimSoulPotence/iCasterSoulPotence)/10) as float
   if fWaitTime > 0.10
	fWaitTime = 0.10
   endif

  int iWaitMinute = (fWaitTime * 60) as int
  string stPlural

  if iWaitMinute > 1
     stPlural = "s"
  else
     stPlural = ""
  endif

   Debug.Notification("You feel that your 'patient' is coming back from the dead...")
   Debug.Notification("...but it will take " + iWaitMinute + "  minutes.")
   Debug.Notification("Leaving your 'patient' alone wouldn't be *nice*...")
   Debug.Notification("...even for a necromancer!")
   Debug.Notification("Please wait...")
   Utility.WaitGameTime(fWaitTime)
   acTarget.Resurrect()
   Debug.Notification("The 'patient' will be weak and confused for " + iWaitMinute + " minutes.")
   float fOldConfidence = acTarget.GetAV("confidence")
   fVictimSpeed = acTarget.GetAV("speedmult")
   acTarget.DamageAV("speedmult", -(fVictimSpeed*0.8))
   acTarget.setAV("confidence", 4)
   Debug.Notification("Coming back from death is a great shock...")
   Utility.WaitGameTime(fWaitTime)
   acTarget.setAV("confidence", fOldConfidence)   
   acTarget.RestoreAV("speedmult", (fVictimSpeed*0.8))
   
else
  
   Debug.Notification("The spirit of your 'patient' is dragging you into death!!")
   float fSpeedReduction = (acActivator.GetActorValue("speedmult"))*0.8
   fWaitTime = ((iVictimSoulPotence - iCasterSoulPotence)/iCasterSoulPotence) as float

   if fWaitTime > 24.0
	   fWaitTime = 24.0
    endif
	acActivator.DamageActorValue("health", -((acActivator.GetActorValue("health") - 2)))
	acActivator.DamageActorValue("magicka", -((acActivator.GetActorValue("magicka") - 2)))
	acActivator.DamageActorValue("stamina", -((acActivator.GetActorValue("stamina") - 2)))
	acActivator.DamageActorValue("speedmult", -fSpeedReduction)

   Debug.Notification("Please!! Please!! Leave it!!")

    Debug.Notification("...you survived, but will take time to recover.")
    Utility.WaitGameTime(fWaitTime)
    acActivator.RestoreActorValue("speedmult", fSpeedReduction)   
    Debug.Notification("You recovered.")

endif

EndEvent
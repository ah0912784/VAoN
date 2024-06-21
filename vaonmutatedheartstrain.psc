Scriptname VAoNMutatedHeartStrain extends ActiveMagicEffect

import ObjectReference
import Actor

Event OnEffectStart(Actor akTarget, Actor akCaster)

acMutant = akTarget


  if (!(acMutant.GetLeveledActorBase().IsEssential())) || (!(acMutant.GetLeveledActorBase().IsProtected()))	
	blMutatedEssence = FALSE
  else
	blMutatedEssence = TRUE
	acMutant.GetLeveledActorBase().SetEssential(true)	
  endif

arOriginalSpeed[0] = acMutant.GetAV("speedmult")

arOriginalSpeed[1] = acMutant.GetAV("weaponspeedmult")

arOriginalSpeed[2] = acMutant.GetAV("leftweaponspeedmult")

acMutant.ModAV("speedmult", (arOriginalSpeed[0])*2)
acMutant.ModAV("weaponspeedmult", (arOriginalSpeed[1])*2)
acMutant.ModAV("leftweaponspeedmult", (arOriginalSpeed[2])*2)


fOriginalStatRateMultiplier[0] = acMutant.GetAV("healratemult")

fOriginalStatRateMultiplier[1] = acMutant.GetAV("magickaratemult")

fOriginalStatRateMultiplier[2] = acMutant.GetAV("staminaratemult")


acMutant.DamageActorValue("staminaratemult", -(fOriginalStatRateMultiplier[2])*2)

arStrainActive[2] = TRUE																

	RegisterForUpdate(1)	

endEvent


Event OnUpdate() 

fCurrentStatValue[0] = acMutant.GetAV("healing")

fCurrentStatValue[1] = acMutant.GetAV("magicka")

fCurrentStatValue[2] = acMutant.GetAV("stamina")

   if 	(fCurrentStatValue[2] <=  fMinimumStatValue[2])	|| (arStatEmptied[2] == FALSE)			
	arStatEmptied[2] = TRUE																
	acMutant.RestoreActorValue("staminaratemult", (fOriginalStatRateMultiplier[2]))			
	acMutant.DamageActorValue("magickaratemult", -(fOriginalStatRateMultiplier[1])*2)		
	arStrainActive[1] = TRUE																
    endif

   if 	(fCurrentStatValue[1] <=  fMinimumStatValue[1])	|| (arStatEmptied[1] == FALSE)			
	arStatEmptied[1] = TRUE																
	acMutant.RestoreActorValue("magickaratemult", (fOriginalStatRateMultiplier[1]))					
	acMutant.DamageActorValue("healratemult", -(fOriginalStatRateMultiplier[0])*2)		
	arStrainActive[0] = TRUE																
    endif

    if 	(fCurrentStatValue[0] <=  fMinimumStatValue[0])	|| (arStatEmptied[0] == FALSE)		
	arStatEmptied[0] = TRUE																
	acMutant.RestoreActorValue("healratemult", (fOriginalStatRateMultiplier[0]))		
	UnregisterForUpdate()	
    endif
	
   if 	(fCurrentStatValue[2] >  fMinimumStatValue[2])	|| (arStatEmptied[2] == TRUE)			
	acMutant.DamageActorValue("magicka", -(fCurrentStatValue[2] - fMinimumStatValue[2]) )				
	acMutant.RestoreActorValue("stamina", (fCurrentStatValue[2] - fMinimumStatValue[2]) )								
    endif

    if 	(fCurrentStatValue[1] >  fMinimumStatValue[1])	|| (arStatEmptied[1] == TRUE)			
	acMutant.DamageActorValue("stamina", -(fCurrentStatValue[1] - fMinimumStatValue[1]) )				
	acMutant.RestoreActorValue("healing", (fCurrentStatValue[1] - fMinimumStatValue[1]) )								
    endif

EndEvent


Event OnEffectEnd(Actor akTarget, Actor akCaster)

if  arStatEmptied[1] == TRUE

	acMutant.RestoreActorValue("healratemult", (fOriginalStatRateMultiplier[0]))	

endif

if  arStatEmptied[2] == TRUE

	acMutant.RestoreActorValue("magickaratemult", (fOriginalStatRateMultiplier[1]))	

endif

	acMutant.RestoreActorValue("staminaratemult", (fOriginalStatRateMultiplier[0]))	


  if blMutatedEssence == TRUE	
	acMutant.GetLeveledActorBase().SetEssential(false)	
  endif


  acMutant.SetAV("speedmult", arOriginalSpeed[0])
  acMutant.SetAV("weaponspeedmult", arOriginalSpeed[1])
  acMutant.SetAV("leftweaponspeedmult", arOriginalSpeed[2])

endEvent





Float[] Property fOriginalStatRateMultiplier  Auto  

Float[] Property fMinimumStatValue  Auto  

Bool[] Property arStrainActive  Auto  

Actor Property acMutant  Auto  

Float[] Property fCurrentStatValue  Auto  

Bool[] Property arStatEmptied  Auto  

Bool Property blMutatedEssence  Auto 

Float[] Property arOriginalSpeed  Auto  

Armor Property frmMutatedHeart  Auto  

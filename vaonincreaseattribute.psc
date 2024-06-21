Scriptname VAoNIncreaseAttribute extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
 
  acImbiber = akCaster
  Debug.Messagebox("Your body is permanently enhanced by the elixir...")
  flOldScore = acImbiber.GetBaseActorValue(strAttribute)	
  flNewScore = flOldScore +1
  acImbiber.SetActorValue(strAttribute, flNewScore)	
  flOldScore = 0
  flNewScore = 0

endEvent

String Property strAttribute  Auto  

Actor Property acImbiber  Auto  

Float Property flOldScore  Auto  

Float Property flNewScore  Auto  

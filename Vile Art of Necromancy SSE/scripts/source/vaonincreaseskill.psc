Scriptname VAoNIncreaseSkill extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
 
  acImbiber = akCaster
  Debug.Messagebox("Your mastery of this skill is permanently enhanced by the elixir...")
  Game.IncrementSkillBy(strSkill, 1)

endEvent

String Property strSkill  Auto  

Actor Property acImbiber  Auto 

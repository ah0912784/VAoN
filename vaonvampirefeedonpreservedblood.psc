Scriptname VAoNVampireFeedonPreservedBlood extends activemagiceffect  

Message Property msgFeedingMessage  Auto  

GlobalVariable Property gvPlayerVampire  Auto  

PlayerVampireQuestScript Property PlayerIsVampireQuest  Auto 

Event OnEffectStart (Actor akTarget, Actor akCaster)

Actor acPlayer = Game.GetPlayer()

	if gvPlayerVampire.Value >= 1
		PlayerIsVampireQuest.VampireFeed()
		msgFeedingMessage.Show()
	endif

	flBaseHealth = acPlayer.GetActorValue("health")
	flBaseSpeed = acPlayer.GetActorValue("speedmult")

	Debug.Notification("Blood drives you into frenzy...")

	acPlayer.ModActorValue("health", 50)
	acPlayer.ModActorValue("speedmult", 4)

EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

Actor acPlayer = Game.GetPlayer()

	flHealthAdjustment= acPlayer.GetActorValue("health") - flBaseHealth
	flSpeedAdjustment = acPlayer.GetActorValue("speedmult") - flBaseSpeed

	Debug.Notification("The effect of frenzy wanes...")

	acPlayer.ModActorValue("health", flHealthAdjustment)
	acPlayer.ModActorValue("speedmult", flSpeedAdjustment)

EndEvent



Float Property flBaseHealth  Auto  

Float Property flBaseSpeed  Auto  


Float Property flHealthAdjustment  Auto  

Float Property flSpeedAdjustment  Auto  


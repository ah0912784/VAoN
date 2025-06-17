Scriptname VAoNMarkAsForbidden extends ObjectReference  
{This makes an item forbidden as soon as it's added to the game.}


Event OnInit() ; This event will run once, when the script is initialized

	Self.SetFactionOwner(faOblivionMade)

	if (Game.GetPlayer().GetItemCount(Self)) > 0
	   Self.SendStealAlarm(Game.GetPlayer())
	   blAlreadyStolen = TRUE
	else
	  blAlreadyStolen = FALSE
	endif

EndEvent



Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

	if (akNewContainer == Game.GetPlayer()) || (blAlreadyStolen == FALSE)

		Self.SetFactionOwner(faOblivionMade) 

		if (Game.GetPlayer().GetItemCount(Self)) > 0
		   Self.SendStealAlarm(Game.GetPlayer())
		endif

	endif

EndEvent

Faction Property faOblivionMade  Auto  

Bool Property blAlreadyStolen  Auto  

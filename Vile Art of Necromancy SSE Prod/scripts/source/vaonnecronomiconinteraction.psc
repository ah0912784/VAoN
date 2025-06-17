Scriptname VAoNNecronomiconInteraction extends ObjectReference  

import actor

import globalvariable


Message[] Property arMessageList  Auto  

SPELL[] Property arNecronomiconSpells  Auto  

Perk[] Property arNecronomiconPerks  Auto  


Event OnInit() 

	Self.BlockActivation()

EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

		Self.BlockActivation()

EndEvent


Event OnActivate(ObjectReference akActionRef)

	Actor acActivator = akActionRef as Actor


	int iMenuSelection
	int iKnowledgeSelection
	int iConfigurationSelection

	iMenuSelection = arMessageList[0].Show()

	if iMenuSelection == 0

		acActivator.AddItem(Self, 1)

	GoToState("EndActivation")
	Return
	
	elseif iMenuSelection == 1
		
		Self.Activate(acActivator, true)

	GoToState("EndActivation")
	Return

	elseif iMenuSelection == 2

		iKnowledgeSelection = arMessageList[1].Show()

		if iKnowledgeSelection == 0

			acActivator.AddPerk(arNecronomiconPerks[0])
			arMessageList[2].Show()			
			GoToState("EndActivation")
			Return
		
		elseif iKnowledgeSelection == 1

			acActivator.AddPerk(arNecronomiconPerks[1])
			arMessageList[3].Show()		
			GoToState("EndActivation")
			Return

		elseif iKnowledgeSelection == 2

			acActivator.AddSpell(arNecronomiconSpells[0])
			GoToState("EndActivation")
			Return

		elseif iKnowledgeSelection == 3

			acActivator.AddSpell(arNecronomiconSpells[1])
			GoToState("EndActivation")
			Return

		elseif iKnowledgeSelection == 4

			acActivator.AddSpell(arNecronomiconSpells[2])
			GoToState("EndActivation")
			Return

		elseif iKnowledgeSelection == 5

			acActivator.AddSpell(arNecronomiconSpells[3])
			GoToState("EndActivation")
			Return


		elseif iKnowledgeSelection == 6

			acActivator.AddSpell(arNecronomiconSpells[4])
			GoToState("EndActivation")
			Return

		endif

	elseif iMenuSelection == 4

		 iConfigurationSelection = arMessageList[4].Show()

	    if  iConfigurationSelection == 0

			acActivator.RemovePerk(arNecronomiconPerks[2])
			acActivator.AddPerk(arNecronomiconPerks[0])
			Debug.Notification("Vanilla Anatomy activated.")
			GoToState("EndActivation")
			Return
		
		elseif  iConfigurationSelection == 1

			acActivator.RemovePerk(arNecronomiconPerks[0])
			acActivator.AddPerk(arNecronomiconPerks[2])
			Debug.Notification("Alternate Anatomy activated.")
			GoToState("EndActivation")
			Return

		elseif  iConfigurationSelection == 2

			glOrderlyDissectionSwitch.SetValue(0)

		elseif  iConfigurationSelection == 3

			glOrderlyDissectionSwitch.SetValue(1)

		endif


	endif


EndEvent


State EndActivation

EndState
GlobalVariable Property glOrderlyDissectionSwitch  Auto  

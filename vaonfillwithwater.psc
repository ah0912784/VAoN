Scriptname VAoNFillWithWater extends ObjectReference  

import actor


Event OnInit() 

	Self.BlockActivation()

EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

		Self.BlockActivation()

EndEvent


Event OnActivate(ObjectReference akActionRef)

	Actor acActivator = akActionRef as Actor

	int iMenuSelection

	int iFillSelection
    
      int iBucketNumber

      iBucketNumber = (acActivator.GetActorValue("stamina")/10) as int

	iMenuSelection =  msgBucketActivation.Show()

	If iMenuSelection == 0 

        iFillSelection = msgBucketMultiFill.Show()

        If iFillSelection == 0
	     Game.ForceThirdPerson()
            Debug.Notification("You have filled your bucket from a nearby water source.")
            Utility.Wait(1)
            Debug.Notification("You have bottled your water.")
            acActivator.AddItem(ptWater,4)		
            GoToState("EndActivation")
	      Return
        Elseif  iFillSelection == 1
	     Game.ForceThirdPerson()
            Debug.Notification("You have filled your bucket " + iBucketNumber + " times..." )
            Utility.Wait(3)
            Debug.Notification("...and bottled all water you've taken.")
            acActivator.AddItem(ptWater,(4*iBucketNumber))		
            Debug.Notification("Now you are very tired...")
	     acActivator.DamageActorValue("stamina", (iBucketNumber*5))
            GoToState("EndActivation")
	      Return
        EndIf

	 Elseif iMenuSelection == 1

	   acActivator.AddItem(Self, 1)
	   GoToState("EndActivation")
	   Return

	EndIf

EndEvent


State EndActivation

EndState

Message Property msgBucketActivation  Auto  

Potion Property ptWater  Auto  

Message Property msgBucketMultiFill  Auto  

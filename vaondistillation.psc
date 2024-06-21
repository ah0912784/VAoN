Scriptname VAoNDistillation extends ObjectReference  
{This script grants distillation perks according to your skill level.}

Perk[] Property pkDistillationPerkbyRank  Auto  

Float[] Property arAlchemySkillRanks  Auto  

int iCount

int iRanksNumber

float fActivatorCurrentAlchemySkill

Event OnEquipped(Actor akActor)

fActivatorCurrentAlchemySkill = akActor.GetActorValue("alchemy")

Debug.Notification("You've set up the distiller.")

iRanksNumber = arAlchemySkillRanks.Length

While iCount < iRanksNumber

   if akActor.HasPerk(pkDistillationPerkbyRank[iCount])
         akActor.RemovePerk(pkDistillationPerkbyRank[iCount])
   endif	   
	
iCount += 1

EndWhile  

If fActivatorCurrentAlchemySkill >= arAlchemySkillRanks[0]
    akActor.AddPerk(pkDistillationPerkbyRank[0])
elseif fActivatorCurrentAlchemySkill >= arAlchemySkillRanks[1]
    akActor.AddPerk(pkDistillationPerkbyRank[1])
elseif fActivatorCurrentAlchemySkill >= arAlchemySkillRanks[2]
    akActor.AddPerk(pkDistillationPerkbyRank[2])
else
    akActor.AddPerk(pkDistillationPerkbyRank[3])
endif

endEvent


Event OnUnequipped(Actor akActor)


iRanksNumber = arAlchemySkillRanks.Length

While iCount < iRanksNumber

     if akActor.HasPerk(pkDistillationPerkbyRank[iCount])
         akActor.RemovePerk(pkDistillationPerkbyRank[iCount])
    endif	   
	
iCount += 1

EndWhile    
	
Debug.Notification("You've packed up the distiller.")	

endEvent
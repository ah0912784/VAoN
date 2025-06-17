Scriptname VAoNEmpowering extends ObjectReference  
{This script grants empowering perks according to your skill level.}

Perk[] Property pkMimirPerkbyRank  Auto  

Float[] Property arEnchantSkillRanks  Auto  

int iCount

int iRanksNumber

float fActivatorCurrentEnchantSkill

Event OnEquipped(Actor akActor)

fActivatorCurrentEnchantSkill = akActor.GetActorValue("enchanting")

Debug.Notification("Your mind is filled with eldritch knowledge of the dead...")

iRanksNumber = arEnchantSkillRanks.Length

While iCount < iRanksNumber

	if akActor.HasPerk(pkMimirPerkbyRank[iCount])
         akActor.RemovePerk(pkMimirPerkbyRank[iCount])
	endif	   
	
iCount += 1

EndWhile  

If fActivatorCurrentEnchantSkill >= arEnchantSkillRanks[0]
    akActor.AddPerk(pkMimirPerkbyRank[0])
elseif fActivatorCurrentEnchantSkill >= arEnchantSkillRanks[1]
    akActor.AddPerk(pkMimirPerkbyRank[1])
elseif fActivatorCurrentEnchantSkill >= arEnchantSkillRanks[2]
    akActor.AddPerk(pkMimirPerkbyRank[2])
else
    akActor.AddPerk(pkMimirPerkbyRank[3])
endif

endEvent


Event OnUnequipped(Actor akActor)


iRanksNumber = arEnchantSkillRanks.Length

While iCount < iRanksNumber

	if akActor.HasPerk(pkMimirPerkbyRank[iCount])
         akActor.RemovePerk(pkMimirPerkbyRank[iCount])
	endif	   
	
iCount += 1

EndWhile    
	
Debug.Notification("The eldritch knowledge of the dead leaves you.")	

endEvent


String[] Property strTestString  Auto  

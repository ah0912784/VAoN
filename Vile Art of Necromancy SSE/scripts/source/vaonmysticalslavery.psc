Scriptname VAoNMysticalSlavery extends ActiveMagicEffect  
{This script cause a creature to become an undead minion of the caster (if player) and to assume a more aggressive and protective approach than in life.}

import Actor
import ObjectReference

Faction Property faMinionState  Auto  
{This is the faction that corresponds to the condition of being a minion of the player.}

string sOutput

Event OnEffectStart(Actor akTarget, Actor akCaster)

akTarget.SetActorValue("aggression", 1)
akTarget.SetActorValue("confidence", 4)
akTarget.SetActorValue("morality", 0)
akTarget.SetActorValue("assistance", 1)

if Game.Getplayer() == akCaster

   akTarget.AddToFaction(faMinionState)
   akTarget.SetPlayerTeammate(true,true)

endif

EndEvent


Event OnEffectEnd(Actor akTarget, Actor akCaster)

akTarget.SetActorValue("aggression", 0)
akTarget.SetActorValue("confidence", 0)
akTarget.SetActorValue("morality", 3)
akTarget.SetActorValue("assistance", 0)

if Game.Getplayer() == akCaster

   akTarget.RemoveFromFaction(faMinionState)
   akTarget.SetPlayerTeammate(false,false)

endif

EndEvent







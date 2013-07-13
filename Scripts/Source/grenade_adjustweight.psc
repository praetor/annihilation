Scriptname grenade_adjustweight extends activemagiceffect  
{Slightly adjusts targets carry weight which forces the game to recalculate the speed.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float f = akTarget.GetActorValue("CarryWeight")
	akTarget.SetActorValue("CarryWeight", f + 1)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	float f = akTarget.GetActorValue("CarryWeight")
	akTarget.SetActorValue("CarryWeight", f - 1)
EndEvent
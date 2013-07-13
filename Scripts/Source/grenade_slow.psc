Scriptname grenade_slow extends activemagiceffect  

float origSpeedmult
float Property Multiplier = 1.0 auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	origSpeedmult = akTarget.GetAV("speedmult")
	akTarget.ForceAV("speedmult", origSpeedmult * Multiplier)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.ForceAV("speedmult", origSpeedmult)
EndEvent
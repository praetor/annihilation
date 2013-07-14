Scriptname grenade_slow extends activemagiceffect  

float origSpeedmult = 100.0
float limitSpeedMult = 50.0

float Property Multiplier = 1.0 auto
MiscObject Property WeightItem Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	origSpeedmult = akTarget.GetAV("speedmult")
	limitSpeedMult = origSpeedmult * Multiplier
	akTarget.ForceAV("speedmult", limitSpeedMult)
	akTarget.AddItem(WeightItem, 1, true)
	
	RegisterForUpdate(0.5)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
	
	akTarget.ForceAV("speedmult", origSpeedmult)
	akTarget.RemoveItem(WeightItem, 1, true)
EndEvent

Event OnUpdate()
	float speed = GetTargetActor().GetAV("speedmult")
	if speed > limitSpeedMult
		GetTargetActor().ForceAV("speedmult", limitSpeedMult)
	endif
EndEvent
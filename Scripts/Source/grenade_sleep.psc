Scriptname grenade_sleep extends activemagiceffect  
{While the effect is active the target is kept paralyzed and unaware of their surroundings}

float startTime = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)
	; Applying the push causes the actor to ragdoll
	Game.GetPlayer().PushActorAway(akTarget, 0.0)
	akTarget.ApplyHavokImpulse(0.0, 0.0, 1.0, 1.0)
	
	akTarget.SetUnconscious(true)
	startTime = Utility.GetCurrentRealTime()
	
	Utility.Wait(0.25)
	akTarget.SetAV("Paralysis", 1)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.SetAV("Paralysis", 0)
	akTarget.SetUnconscious(false)
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if Utility.GetCurrentRealTime() - startTime > 0.25
		Dispel()
	endif
EndEvent
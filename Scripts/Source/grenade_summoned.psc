Scriptname grenade_summoned extends activemagiceffect  
{A script for controlling the AI of grenade summoned creatures.}

float Property AttackRadius Auto
VisualEffect Property DeathEffect Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForUpdate(0.5)
	
	Actor attackTarget = GetNewTarget(akTarget)
	
	if attackTarget != None
		Debug.Notification("Found none player target")
		akTarget.StartCombat(attackTarget)
	else
		Utility.Wait(0.4)
		akTarget.StopCombat()
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
	
	if akTarget.GetAV("health") > 0.0
		DeathEffect.Play(akTarget, 3.0, akCaster)
		akTarget.Delete()
	endif
EndEvent

Event OnUpdate()
	if GetTargetActor().GetCombatState() == 1 && GetTargetActor().GetCombatTarget() == Game.GetPlayer()
		Actor attackTarget = GetNewTarget(GetTargetActor())
		if attackTarget != None
			Debug.Notification("Found none player target")
			GetTargetActor().StartCombat(attackTarget)
		endif
	endif
EndEvent

Actor Function GetNewTarget(Actor akTarget)
	; Try to find a non-player target
	Actor attackTarget = None
	int n = 0
	while attackTarget == None && n < 5
		Actor possibleTarget = Game.FindRandomActorFromRef(akTarget, AttackRadius)
		if possibleTarget != Game.GetPlayer()
			attackTarget = possibleTarget
		endif
		n = n + 1
	endwhile
	return attackTarget
EndFunction
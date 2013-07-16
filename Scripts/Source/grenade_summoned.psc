Scriptname grenade_summoned extends activemagiceffect  
{A script for controlling the AI of grenade summoned creatures.}

float Property AttackRadius Auto
VisualEffect Property DeathEffect Auto

float startTime = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)
	startTime = Utility.GetCurrentRealTime()
	RegisterForUpdate(0.5)
	
	Utility.Wait(0.5)
	
	akTarget.SetPlayerTeammate(true, false)
	
	Debug.Notification("Health: " + GetTargetActor().GetAV("health") + " / Melee: " + GetTargetActor().GetAV("MeleeDamage") + " / Unarmed: " + GetTargetActor().GetAV("UnarmedDamage"))
EndEvent

Event OnUpdate()
	if Utility.GetCurrentRealTime() - startTime >= 30.0
		UnregisterForUpdate()
		
		if DeathEffect != None
			DeathEffect.Play(GetTargetActor(), 2.0, GetTargetActor())
			Utility.Wait(2.0)
		endif
		
		GetTargetActor().Delete()
	else
		if GetTargetActor().GetCombatTarget() == Game.GetPlayer()
			GetTargetActor().StopCombat()
		endif
		
		if GetTargetActor().GetAV("health") <= 0.0
			GetTargetActor().Delete()
		endif
	endif
EndEvent
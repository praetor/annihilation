Scriptname grenade_summoned extends activemagiceffect  
{A script for controlling the AI of grenade summoned creatures.}

float Property AttackRadius Auto
VisualEffect Property DeathEffect Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForUpdate(0.5)
	
	Utility.Wait(0.5)
	
	akTarget.SetPlayerTeammate(true, false)
	
	Debug.Notification("Health: " + GetTargetActor().GetAV("health") + " / Melee: " + GetTargetActor().GetAV("MeleeDamage") + " / Unarmed: " + GetTargetActor().GetAV("UnarmedDamage"))
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
	
	if akTarget.GetAV("health") > 0.0
		DeathEffect.Play(akTarget, 3.0, akCaster)
		akTarget.Delete()
	endif
EndEvent

Event OnUpdate()
	if GetTargetActor().GetCombatTarget() == Game.GetPlayer()
		GetTargetActor().StopCombat()
	endif
	
	if GetTargetActor().GetAV("health") <= 0.0
		GetTargetActor().Delete()
	endif
EndEvent
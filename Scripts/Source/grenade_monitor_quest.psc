Scriptname grenade_monitor_quest extends Quest  
{Maintenance code to manage global settings needed for grenades and bombs.}

Keyword Property MonitorKeyword Auto
Spell Property MonitorAbility Auto
Keyword Property DrinkKeyword Auto
Spell Property DrinkAbility Auto

Event OnInit()
	StartChecking()
EndEvent

Event OnUpdate()
	; Check on the player for the monitor spell
	Actor player = Game.GetPlayer()
	if !player.HasMagicEffectWithKeyword(MonitorKeyword)
		player.AddSpell(MonitorAbility, false)
	endif
	if !player.HasMagicEffectWithKeyword(DrinkKeyword)
		player.AddSpell(DrinkAbility, false)
	endif
EndEvent

Function StartChecking()
	UnregisterForUpdate()
	Utility.Wait(0.1)
	RegisterForUpdate(0.5)
EndFunction
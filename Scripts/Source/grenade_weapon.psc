Scriptname grenade_weapon extends ObjectReference  
{Script on all grenade weapon objects that the player equips}

Spell Property MonitorSpell Auto

Event OnEquipped(Actor akActor)
	; Add the monitor spell so we know when this weapon was swung
	akActor.AddSpell(MonitorSpell, false)
EndEvent

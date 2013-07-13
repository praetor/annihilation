Scriptname grenade_weapon extends ObjectReference  
{Script on all grenade weapon objects that the player equips}

Spell Property MonitorSpell Auto
Spell Property MonitorDispelSpell Auto

Event OnEquipped(Actor akActor)
	akActor.AddSpell(MonitorDispelSpell, false)
	Utility.Wait(0.25)
	
	; Add the monitor spell so we know when this weapon was swung
	akActor.AddSpell(MonitorSpell, false)
EndEvent

Scriptname grenade_playeralias extends ReferenceAlias  

grenade_monitor_quest Property QuestScript Auto
 
Event OnPlayerLoadGame()
	QuestScript.StartChecking()
EndEvent

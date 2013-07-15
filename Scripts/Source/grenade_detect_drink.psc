Scriptname grenade_detect_drink extends activemagiceffect  
{Detects when you drink wine and such and adds empty bottles.}

Potion[] Property FullBottles auto
MiscObject[] Property EmptyBottles auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	Potion bottle = akBaseObject as Potion
	if bottle != None
		int index = FullBottles.Find(bottle)
		if index >= 0
			GetTargetActor().AddItem(EmptyBottles[index], 1)
		endif
	endif
EndEvent

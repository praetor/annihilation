Scriptname bomb_weapon extends ObjectReference  
{Handles placing bombs in the world when they are equipped.}

Activator Property BombTrap Auto
Weapon Property BombWeapon Auto

Event OnEquipped(Actor akActor)
	; Place an object in front of the player
	ObjectReference obj = akActor.PlaceAtMe(BombTrap, 1, true)
	obj.MoveTo(akActor, 80.0 * Math.Sin(akActor.GetAngleZ()), 80.0 * Math.Cos(akActor.GetAngleZ()), akActor.Z)
	obj.SetAngle(0, 0, 0)
	obj.SetActorCause(akActor)
	obj.SetActorOwner(akActor.GetActorBase())
	
	bomb_pressure_plate plate = obj as bomb_pressure_plate
	if plate != None
		plate.owningActorBase = akActor.GetActorBase()
	endif
	
	; Now get rid of it
	akActor.UnequipItem(BombWeapon, false, true)
	akActor.RemoveItem(BombWeapon, 1, true)
EndEvent
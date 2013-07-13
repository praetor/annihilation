Scriptname grenade_monitor_throw extends activemagiceffect  
{Effect for actor to know when they are swinging the grenade so we can throw it}

Weapon Property ProxyWeapon Auto
Keyword Property GrenadeKeyword Auto
Weapon[] Property GrenadeWeapons Auto
Ammo[] Property GrenadeAmmos Auto

ObjectReference ThrowProxy = None

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForAnimationEvent(akTarget, "WeaponLeftSwing")    
	RegisterForAnimationEvent(akTarget, "WeaponSwing")
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForAnimationEvent(akTarget, "WeaponLeftSwing")    
	UnregisterForAnimationEvent(akTarget, "WeaponSwing")
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	Actor akActor = akSource as Actor
	if akActor != None
		Weapon currentGrenade = None
		bool leftHand = false
		if asEventName == "WeaponSwing"
			currentGrenade = akActor.GetEquippedWeapon(false)
		elseif asEventName == "WeaponLeftSwing"
			currentGrenade = akActor.GetEquippedWeapon(true)
			leftHand = true
		endif
		
		if currentGrenade != None && !currentGrenade.HasKeyword(GrenadeKeyword)
			currentGrenade = None
		endif
		
		if currentGrenade == None
			; Debug.Notification("Not grenade swing")
		else
			; Search through our arrays and find the right kind of ammo
			int index = GrenadeWeapons.Find(currentGrenade)
			if index >= 0
				; Ensure we have a proxy weapon
				if ThrowProxy == None 
					ThrowProxy = akSource.PlaceAtMe(ProxyWeapon, 1, true)
					ThrowProxy.SetActorCause(akActor)
				endif
				
				ThrowProxy.MoveTo(akSource, 80.0 * Math.Sin(akSource.GetAngleZ()), 80.0 * Math.Cos(akSource.GetAngleZ()), akSource.GetHeight() - 25.0)
				ThrowProxy.SetAngle(akSource.GetAngleX() - 5, akSource.GetAngleY(), akSource.GetAngleZ())
				
				Ammo currentAmmo = GrenadeAmmos[index]
				currentGrenade.Fire(ThrowProxy, currentAmmo)
				
				; Unequip and remove one grenade object
				if leftHand
					akActor.UnequipItemEx(currentGrenade, 2)
				else
					akActor.UnequipItemEx(currentGrenade, 1)
				endif
				akActor.RemoveItem(currentGrenade, 1, true)
				
				; Now equip a new grenade from inventory if there is one
				Utility.Wait(0.25)
				if akActor.GetItemCount(currentGrenade) > 0
					if leftHand
						akActor.EquipItemEx(currentGrenade, 2)
					else
						akActor.EquipItemEx(currentGrenade, 1)
					endif
				endif
			endif
		endif
	endif
EndEvent

Scriptname bomb_pressure_plate extends TrapTriggerBase  
{Script to handle the behavior of getting activated.}

Explosion property pressExplosion auto
Weapon Property Bomb Auto

State Active
	Event onBeginState()
		objectReference selfRef = self
		goToState( "DoNothing" )
		
		if (StoredTriggerType == 1)
			Type = 3
			utility.wait(0.1)
			activate(self as objectReference)
			utility.wait(0.1)
			;Type = 1
		else
			activate(self as objectReference)
		endif
		
		TriggerSound.play(self)
		playAnimation("Down")
		
		if pressExplosion != None 
			PlaceAtMe(pressExplosion, 1)
		endif
		
		Delete()
	endEvent
	
	event OnTriggerEnter( objectReference triggerRef )	
		objectsInTrigger = self.GetTriggerObjectCount()
	endEvent
	
	event OnTriggerLeave( objectReference triggerRef )
		objectsInTrigger = self.GetTriggerObjectCount()
		if objectsInTrigger == 0
			goToState ("Inactive")
			playAnimation("Up")
		endif
	endEvent
endState

State DoNothing
	event OnTriggerEnter( objectReference triggerRef )	
		objectsInTrigger = self.GetTriggerObjectCount()
	endEvent
	
	event OnTrigger( objectReference triggerRef )	
	endEvent
	
	event OnTriggerLeave( objectReference triggerRef )
		objectsInTrigger = self.GetTriggerObjectCount()
		if objectsInTrigger == 0
			goToState ("Inactive")
			playAnimation("Up")
		endif
	endEvent
EndState

Event onActivate(objectReference akActivator)
	if Bomb != None
		akActivator.AddItem(Bomb, 1)
		Delete()
	endif
EndEvent
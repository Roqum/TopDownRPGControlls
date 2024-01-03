extends State

@onready var camera = $Camera3D

func update(delta):
	if camera.get_movement_marker().has_overlapping_bodies():
		transition.emit(self, "idle")

func physics_update(delta):
	pass

func state_enter():
	pass
	
func state_exit():
	pass

extends State

@export var animation_player : AnimationPlayer
@onready var player = $"../.."
@onready var camera = $Camera3D

func update(delta):
	pass
	
func physics_update(delta):
	if Input.is_mouse_button_pressed(1):
		var ray = camera.screen_to_world_ray()
		print(ray)
		if ray.get("collider").name == "Terrain":
			transition.emit(self,"move")

func state_enter():
	animation_player.play("great_sword_idle_1")
	
func state_exit():
	pass

extends CharacterBody3D

class_name BasicCharacterControll

const PlayerCharacterHeader = preload("res://scripts/PlayerCharacter/PlayerCharacterHeader.gd")

const SPEED = 10.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_state = PlayerCharacterHeader.CHARACTER_STATE.UNOCCUPIED
var target_direction

@onready var movement_marker = $"../MovementMarker"
@onready var camera = $"../Camera3D"
@onready var mesh = $MainCharacterVisuals

#virtual function
func basic_attack():
	pass

func _ready():
	set_up_movement_marker()
	
func _process(delta):
	if Input.is_mouse_button_pressed(1):
		screen_to_world_position()
	
func _physics_process(delta):
	camera.global_position = global_position + Vector3(0,10,5)

	if current_state == PlayerCharacterHeader.CHARACTER_STATE.RUNNING:
		target_direction = (movement_marker.global_position - global_position).normalized() 
		target_direction.y = 0
		velocity = (transform.basis * target_direction).normalized() * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	velocity.y -= gravity * delta
	move_and_slide()	
		
func screen_to_world_position():
	var position = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var ray_origin = camera.project_ray_origin(position)
	var ray_direction = ray_origin + camera.project_ray_normal(position) * 1000.0
	var ray = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction, 524288)
	ray.collide_with_areas = true
	var ray_hit = space_state.intersect_ray(ray)
	handle_mouse_input(ray_hit)
	
func handle_mouse_input(mouse_position):
	movement_marker.global_position = mouse_position.position		
	target_direction = (movement_marker.global_position - global_position).normalized()
	target_direction.y = 0
	mesh.look_at(-target_direction * 100)
	if mouse_position.get("collider").name == "HitBoxComponent":
		current_state = PlayerCharacterHeader.CHARACTER_STATE.ATTACKING
		basic_attack()
	elif mouse_position.get("collider").name == "Terrain":
		current_state = PlayerCharacterHeader.CHARACTER_STATE.RUNNING		

func set_up_movement_marker():
	movement_marker.body_entered.connect(_on_movement_marker_body_entered)
	
func _on_movement_marker_body_entered(body: Node3D):
	current_state = PlayerCharacterHeader.CHARACTER_STATE.UNOCCUPIED

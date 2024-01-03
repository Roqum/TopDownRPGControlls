extends CharacterBody3D

class_name BasicCharacterControll

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

var mouse_world_position
var movement = false
var target_direction

@onready var state_machine = $StateMachine
@onready var movement_marker = $"../MovementMarker"
@onready var camera = $"../Camera3D"
@onready var animation = $MainCharacterVisuals/GreatSwordCharacterAnimated/AnimationPlayer
@onready var mesh = $MainCharacterVisuals

var weapon_hitbox
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	set_up_movement_marker()
	
func basic_input(delta):
	if Input.is_mouse_button_pressed(1):
		screen_to_world_position()
	
func basic_input_physic(delta):
	camera.global_position = global_position + Vector3(0,10,5)
	if !movement:
		if !animation.is_playing():
			animation.play("great_sword_idle_1")
	if movement:
		if !animation.is_playing():
			animation.play("great_sword_run")
		target_direction = (movement_marker.global_position - global_position).normalized()
		mesh.look_at(-target_direction * 100) 
		
		target_direction.y = 0
		velocity = (transform.basis * target_direction).normalized() * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	velocity.y -= gravity * delta
	move_and_slide()	
		
		#look_at_from_position(-movement_marker.global_position)		
		#translate(movement_direction * SPEED * delta)
		
func screen_to_world_position():
	var position = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var ray_origin = camera.project_ray_origin(position)
	var ray_direction = ray_origin + camera.project_ray_normal(position) * 1000.0
	var ray = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction, 524288)
	ray.collide_with_areas = true
	var ray_hit = space_state.intersect_ray(ray)
	movement_marker.global_position = ray_hit.position		
	target_direction = (movement_marker.global_position - global_position).normalized()
	target_direction.y = 0
	if ray_hit.get("collider").name == "HitBoxComponent":
		basic_attack()
	elif ray_hit.get("collider").name == "Terrain":
		move_to_target()

func set_up_movement_marker():
	movement_marker.body_entered.connect(_on_movement_marker_body_entered)
	
func _on_movement_marker_body_entered(body: Node3D):
	movement = false
	animation.play("great_sword_idle_1")

func basic_attack():
	movement = false
	mesh.look_at(-target_direction * 100)
	animation.play("great_sword_attack_1")
	#print(sword_hitbox)
		
func move_to_target():
	if !movement_marker.has_overlapping_bodies():
		animation.play("great_sword_run")
		movement = true
		
	

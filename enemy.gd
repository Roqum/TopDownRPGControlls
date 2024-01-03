extends CharacterBody3D


var speed = 6
var basis_resistance = 5

var health = 20
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_triggered = false
var aim_towards_character

@onready var mesh = $CSGCylinder3D
@onready var trigger_radius = $TriggerRadius

func _ready():
	trigger_radius.connect("body_entered", _enemy_is_triggered)
	connect("body_entered", _enemy_is_triggered)

func _physics_process(delta):
	if health <= 0:
		dying()
	apply_gravity(delta)
	if is_triggered:
		do_action_after_trigger()
	move_and_slide()

func apply_gravity(delta):
	velocity.y -= gravity * delta

func _enemy_is_triggered(body: Node3D):
	is_triggered = true
	aim_towards_character = body
	mesh.look_at(body.global_position)

func do_action_after_trigger(): 
	var movemen_direction = aim_towards_character.global_position - global_position
	velocity = movemen_direction.normalized() * speed

func dying():
	pass
	

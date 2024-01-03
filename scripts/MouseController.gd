extends Camera3D

@onready var movement_marker = $"../MovementMarker"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func screen_to_world_ray():
	print("here")
	var position = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var ray_origin = project_ray_origin(position)
	var ray_direction = ray_origin + project_ray_normal(position) * 1000.0
	var ray = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction, 524288)
	ray.collide_with_areas = true
	var ray_hit = space_state.intersect_ray(ray)
	movement_marker.global_position = ray_hit.position	
	return ray_hit
	
	'movement_marker.global_position = ray_hit.position		
	target_direction = (movement_marker.global_position - global_position).normalized()
	target_direction.y = 0
	if ray_hit.get("collider").name == "HitBoxComponent":
		basic_attack()
	elif ray_hit.get("collider").name == "Terrain":
		move_to_target()'
		
func set_up_movement_marker():
	movement_marker.body_entered.connect(_on_movement_marker_body_entered)
	
func _on_movement_marker_body_entered(body: Node3D):
	pass
	
func get_movement_marker():
	return movement_marker

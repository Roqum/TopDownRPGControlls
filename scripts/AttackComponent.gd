extends Area3D

class_name AttackComponent

func _ready():
	pass

func _process(delta):
	pass

func _on_area_entered(area):
	if area.get_name() == 'HitBoxComponent':
		area.got_hit()

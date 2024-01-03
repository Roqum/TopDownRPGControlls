extends BasicCharacterControll

#@onready var weapon = $MainCharacterVisuals/GreatSwordCharacterAnimated/Armature_001/Skeleton3D/Weapon/GreatSword

func _ready():
	set_up_movement_marker()
	
func _process(delta):
	basic_input(delta)
	
func _physics_process(delta):
	basic_input_physic(delta)

func basic_attack():
	movement = false
	mesh.look_at(-target_direction * 100)
	animation.play("great_sword_attack_1")
	#print(sword_hitbox)


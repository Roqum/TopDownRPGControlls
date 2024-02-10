extends AnimationPlayer

const PlayerCharacterHeader = preload("res://scripts/PlayerCharacter/PlayerCharacterHeader.gd")

@onready var main_character = $".."

func _process(delta):
	match main_character.current_state:
		PlayerCharacterHeader.CHARACTER_STATE.UNOCCUPIED:
			play("great_sword_idle_1")
		PlayerCharacterHeader.CHARACTER_STATE.RUNNING:
			play("great_sword_run")
		PlayerCharacterHeader.CHARACTER_STATE.ATTACKING:
			play("great_sword_attack_1")

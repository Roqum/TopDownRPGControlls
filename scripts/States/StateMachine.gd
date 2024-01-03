extends Node

class_name state_machine

@export var initial_state: State
@export var camera: Camera3D


var all_states: Dictionary = {}
var current_state

func _ready():
	for child in get_children():
		if child is State:
			all_states[child.name.to_lower()] = child
			child.transition.connect(state_transition)
			
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func state_transition(old_state, new_state_name):
	if old_state != current_state:
		return
		
	var new_state = all_states[new_state_name.to_lower()]
	if !new_state:
		return
		
	if current_state:
		current_state.state_exit()
		
	new_state.state_enter()
	current_state = new_state
	

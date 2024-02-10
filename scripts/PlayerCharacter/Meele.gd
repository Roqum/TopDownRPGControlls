extends BasicCharacterControll


func _ready():
	super._ready()
	
func _process(delta):
	super._process(delta)
	
func _physics_process(delta):
	super._physics_process(delta)

func basic_attack():
	current_state = PlayerCharacterHeader.CHARACTER_STATE.ATTACKING	
	

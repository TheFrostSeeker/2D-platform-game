class_name PlayerPause extends State

func enter_state():
	state_name = "Pause"
	player.debug.text = "Pause"
	player.pause_game()

func update(_delta):
	pass
		
func _physics_process(_delta):
	pass

func handle_animation():
	pass

func draw():
	pass

func exit_state():
	pass

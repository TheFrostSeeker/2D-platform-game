class_name PlayerJumpPeak extends State

func enter_state():
	state_name = "JumpPeak"
	player.debug.text = "JumpPeak"

func update(_delta):
	player.pause_game()
	player.change_state(player.fsm.fall)
	
func _physics_process(_delta):
	pass

func handle_animation():
	pass

func draw():
	pass

func exit_state():
	pass

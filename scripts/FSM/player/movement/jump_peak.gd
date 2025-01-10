class_name PlayerJumpPeak extends State

func enter_state():
	pass

func update(_delta):
	player.pause_game()
	player.change_state(player.fsm.fall)
	
func _physics_process(_delta):
	pass

func handle_animation():
	player.animation.play("jump_peak")

func draw():
	pass

func exit_state():
	pass

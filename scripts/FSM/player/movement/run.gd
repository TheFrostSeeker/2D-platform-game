class_name PlayerRun extends State

func enter_state():
	state_name = "Run"
	player.debug.text = "Run"

func update(_delta):
	player.pause_game()
	player.horizontal_movement()
	player.handle_jump()
	player.handle_dash()
	player.handle_attack()
	player.handle_fall()
	handle_idle()
	handle_animation()
	
func _physics_process(_delta):
	pass

func handle_idle():
	if player.move_direction_x == 0:
		player.change_state(player.fsm.idle)

func handle_animation():
	player.animation.play("run")
	player.handle_flip()

func draw():
	pass

func exit_state():
	pass

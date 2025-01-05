class_name PlayerIdle extends State

func enter_state():
	state_name = "Idle"
	player.debug.text = "Idle"

func update(_delta):
	player.pause_game()
	player.handle_fall()
	player.handle_jump()
	player.handle_roll()
	player.horizontal_movement()
	if player.move_direction_x != 0:
		player.change_state(player.fsm.run)
	handle_animation()
	
func _physics_process(_delta):
	pass

func handle_animation():
	player.sprite.play("idle")
	player.handle_flip()

func draw():
	pass

func exit_state():
	pass

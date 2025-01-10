class_name PlayerJump extends State

func enter_state():
	player.jump_active = true
	player.velocity.y = player.jump_speed

func update(_delta):
	player.pause_game()
	player.apply_gravity(_delta)
	player.horizontal_movement()
	handle_jump_to_fall()
	handle_animation()
	
func _physics_process(_delta):
	pass

func handle_jump_to_fall():
	if player.velocity.y >= 0:
		player.change_state(player.fsm.jump_peak)

func handle_animation():
	player.animation.play("jump")
	player.handle_flip()

func draw():
	pass

func exit_state():
	pass

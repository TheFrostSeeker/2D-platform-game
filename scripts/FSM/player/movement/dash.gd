class_name PlayerDash extends State

func enter_state():
	state_name = "Dash"
	player.debug.text = "Dash"
	player.dash_cooldown.start()
	player.velocity.x = player.dash_speed * player.direction

func update(_delta):
	player.pause_game()
	player.apply_gravity(_delta)
	handle_dash()
	player.handle_dash()
	handle_animation()
	
func _physics_process(_delta):
	pass

func handle_dash():
	if player.dash_active:
		player.velocity.x = player.dash_speed * player.direction
	else:
		player.change_state(player.fsm.idle)

func handle_animation():
	player.animation.play("dash")
	player.handle_ctrl_flip()

func draw():
	pass

func exit_state():
	pass

func _on_dash_cooldown_timeout() -> void:
	player.can_dash = true

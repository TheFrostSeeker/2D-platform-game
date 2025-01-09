class_name PlayerDash extends State

func enter_state():
	state_name = "Dash"
	player.debug.text = "Dash"
	player.direction = -1 if player.facing < 1 else 1
	player.velocity.x = player.dash_speed
	player.dash_cooldown.start()

func update(_delta):
	player.pause_game()
	player.apply_gravity(_delta)
	handle_dash()
	player.handle_dash()
	handle_animation()
	
func _physics_process(_delta):
	pass

func handle_dash():
	player.velocity.x = player.dash_speed * player.direction

func handle_animation():
	player.animation.play("dash")
	player.handle_ctrl_flip()

func draw():
	pass

func exit_state():
	player.handle_counter_reset()

func _on_dash_cooldown_timeout() -> void:
	player.change_state(player.fsm.idle)

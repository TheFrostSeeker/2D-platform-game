class_name PlayerRoll extends State

func enter_state():
	state_name = "Roll"
	player.debug.text = "Roll"
	player.roll_direction = -1 if player.facing < 1 else 1
	player.velocity.x = player.roll_speed
	player.roll_cooldown.start()

func update(_delta):
	player.pause_game()
	player.apply_gravity(_delta)
	handle_roll()
	player.handle_roll()
	handle_animation()
	
func _physics_process(_delta):
	pass

func handle_roll():
	player.velocity.x = player.roll_speed * player.roll_direction

func handle_animation():
	player.sprite.play("roll")
	player.handle_flip()

func draw():
	pass

func exit_state():
	pass

func _on_roll_cooldown_timeout() -> void:
	player.change_state(player.fsm.fall)

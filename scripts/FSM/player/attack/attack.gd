class_name PlayerAttack extends State

func enter_state():
	state_name = "Attack"
	player.debug.text = "Attack"
	player.direction = -1 if player.facing < 1 else 1
	player.velocity.x = 0
	player.first_attack_cooldown.start()

func update(_delta):
	player.pause_game()
	player.apply_gravity(_delta)
	handle_attack()
	handle_animation()

func _physics_process(_delta):
	pass

func handle_attack():
	pass

func handle_animation():
	player.animation.play("attack")
	player.handle_ctrl_flip()

func draw():
	pass

func exit_state():
	player.handle_counter_reset()

func _on_first_attack_cooldown_timeout() -> void:
	player.change_state(player.fsm.idle)

class_name PlayerFall extends State

func enter_state():
	state_name = "Fall"
	player.debug.text = "Fall"

func update(_delta):
	player.pause_game()
	player.apply_gravity(_delta)
	player.horizontal_movement()
	player.handle_land()
	handle_animation()
	
func _physics_process(_delta):
	pass

func handle_animation():
	player.sprite.play("fall")
	player.handle_flip()

func draw():
	pass

func exit_state():
	pass

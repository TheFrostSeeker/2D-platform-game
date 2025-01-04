extends State
class_name PlayerRun

func enter():
	player = get_parent()
	# Sprite management
	sprite = player.get_node("AnimatedSprite2D")
	sprite.play("run")

func update(_delta):		
	var direction = Input.get_axis("move_left", "move_right")
	# Apply movement
	if direction != 0:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
	
	if player.velocity.x == 0:
		player.change_state("idle")
		
	if Input.is_action_just_pressed("jump") and can_jump:
		player.change_state("jump")
		
	if Input.is_action_just_pressed("roll") and can_roll:
		player.change_state("roll")

func exit():
	pass

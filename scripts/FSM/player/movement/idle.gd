extends State
class_name PlayerIdle

func enter():
	player = get_parent()
	# Sprite management
	sprite = player.get_node("AnimatedSprite2D")
	sprite.play("idle")
	# Stop movement
	player.velocity *= Vector2.ZERO

func update(_delta):
	if Input.get_axis("move_right", "move_left"):
		player.change_state("run")
		
	if Input.is_action_just_pressed("jump") and can_jump:
		player.change_state("jump")
		
	if Input.is_action_just_pressed("roll") and can_roll:
		player.change_state("roll")

func exit():
	pass

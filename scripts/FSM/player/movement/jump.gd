extends State
class_name PlayerJump

@export var jump_velocity: float = -325.0
@export var jump_control: float = 100.0

func enter():
	player = get_parent()
	
	# Sprite management
	sprite = player.get_node("AnimatedSprite2D")
	sprite.play("jump")
	
	# Jump management
	player.velocity.y = jump_velocity
	can_jump = false
	can_roll = false

func update(_delta):
	# Horizontal movement
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * jump_control
	
	# Idle state
	if player.velocity.y == 0:
		can_jump = true
		player.change_state("idle")
	
	if player.is_on_floor() and not can_jump:
		player.velocity.y = jump_velocity
		can_jump = false

func _physics_process(delta: float) -> void:
	player.velocity.y = gravity * delta

func exit():
	can_roll = true

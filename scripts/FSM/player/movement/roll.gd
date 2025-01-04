extends State
class_name PlayerRoll

@export var cooldown = 0.533
@export var roll_cooldown: Timer
@export var current_player: CharacterBody2D

func enter():
	current_player = get_parent()
	roll_cooldown = current_player.get_node("FiniteStateMachine/Roll/RollCooldown")
	roll_cooldown.wait_time = cooldown

	sprite = current_player.get_node("AnimatedSprite2D")
	
	# Initialisation
	can_roll = true
	
	roll_cooldown.start()

func update(_delta):
	roll()

func _physics_process(_delta: float) -> void:
	if current_player.velocity.x == 0 and !sprite.is_playing():
		current_player.change_state("idle")

func exit():
	pass

func roll():
	if not can_roll:
		return
		
	can_roll = false
	
	# Sprite management
	sprite.play("roll")
	current_player.velocity.x = speed * roll_velocity * (-1 if sprite.flip_h else 1)

	roll_cooldown.start()

func _on_timer_timeout() -> void:
	can_roll = true
	current_player.change_state("idle")

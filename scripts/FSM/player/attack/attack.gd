class_name PlayerAttack extends State

@export var _animation_player: NodePath
@export var animation: String
@export var next_state: Node2D

@onready var animation_player:AnimationPlayer = get_node(_animation_player)

var action_pressed = false

func enter_state():
	state_name = "Attack"
	player.debug.text = "Attack"
	player.velocity.x = 0
	player.can_attack = false
	action_pressed = false

func update(_delta):
	player.pause_game()
	player.apply_gravity(_delta)
	handle_attack()
	handle_animation()

func handle_attack():
	if next_state and player.can_attack and player.key_attack:
		player.change_state(next_state)
	if not animation_player.is_playing():
		player.change_state(player.fsm.idle)

func handle_animation():
	player.animation.play(animation)
	player.handle_ctrl_flip()

func draw():
	pass

func exit_state():
	pass

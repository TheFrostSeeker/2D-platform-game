@icon("res://assets/icons/FSMSprite.png")

extends Node

class_name FineStateMachine

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var export_state: state

enum state {IDLE, WALK, ATTACK}

var current_state = state.IDLE
	
func _process(delta):
	match current_state:
		state.IDLE:
			print("idle")
			idle_behavior()
		state.WALK:
			print("walk")
			walk_behavior()
		state.ATTACK:
			print("attack")
			attack_behavior()

func idle_behavior():
	for action in ["move_left", "move_right"]:
		if Input.is_action_pressed(action):
			current_state = state.WALK

func walk_behavior():
	for action in ["move_left", "move_right"]:
		if not Input.is_action_pressed(action):
			current_state = state.IDLE
	#if Input.is_action_just_pressed("attack"):
		#current_state = state.ATTACK

func attack_behavior():
	# Gestion de l'attaque
	current_state = state.IDLE  # Retour à l'état idle après l'attaque

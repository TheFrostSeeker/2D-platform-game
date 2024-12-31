@icon("res://assets/icons/StateSprite.png")

extends Node

class_name PlayerIdle

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fine_state_machine: FineStateMachine = $".."

@export var idle_script: Script
@export var move_script: Script

func Enter():
	print("im ideling")
	animated_sprite.play("Idle")
	pass
	
func Update(_delta : float):
	if(Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()):
		print("walkgseighjsd")
		fine_state_machine.state.WALK
		
	#if Input.is_action_just_pressed("Punch")  or Input.is_action_just_pressed("Kick"):
		#state_transition.emit(self, "Attacking")

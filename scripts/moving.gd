extends Node

class_name PlayerMoving

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -325.0
@export var DASH_SPEED: float = 1.5

enum state {IDLE, RUNNING, ROLLING, JUMP, FALL, ATTACK}

var player_state = state.IDLE
var direction = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Enter():
	print("run")
	animated_sprite.play("run")
#
#func get_input():
	#var direction = Input.get_axis("move_left", "move_right")
	## Apply movement
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
#
#func update_animation():
	#if velocity.x < 0:
		#animated_sprite.flip_h = true
	#elif velocity.x > 0:
		#animated_sprite.flip_h = false
		#
	#match(player_state):
		#state.IDLE:
			#animated_sprite.play("idle")
		#state.RUNNING:
			#animated_sprite.play("run")
		#state.ROLLING:
			#animated_sprite.play("roll")
			#_on_animated_sprite_2d_animation_finished("roll")
		#state.JUMP:
			#animated_sprite.play("jump")
		#state.FALL:
			#animated_sprite.play("fall")
		#state.ATTACK:
			#animated_sprite.play("attack")
#
#
#func _physics_process(_delta: float) -> void:
	#if player_state != state.ROLLING and player_state != state.ATTACK:
		#get_input()
#
		#if is_on_floor():
			#if velocity.x == 0:
				#player_state = state.IDLE
			#elif velocity.x != 0:
				#player_state = state.RUNNING
				#
			#if Input.is_action_just_pressed("roll"):
				#player_state = state.ROLLING
#
			#if Input.is_action_just_pressed("jump"):
				#velocity.y = JUMP_VELOCITY
				#player_state = state.JUMP
			## elif Input.is_action_just_pressed("attack"):
				## Attacks here
#
		#elif velocity.y < 0:
			#player_state = state.JUMP
		#else:
			#player_state = state.FALL
#
	#velocity.y += gravity * _delta
	#
	#update_animation()
	#move_and_slide()
#
#
#func _on_animated_sprite_2d_animation_finished(anim_name) -> void:
	#print_debug("toto")
	#player_state = state.IDLE

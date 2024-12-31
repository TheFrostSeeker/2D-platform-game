extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label
@onready var dash = $DurationTimer

const SPEED: float = 100.0
const JUMP_VELOCITY: float = -325.0
const ROLL_SPEED: float = 1.5

enum state {IDLE, RUN, ROLL, JUMP, FALL, ATTACK}

var player_state = state.IDLE
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_rolling = false

func get_input():
	var direction = Input.get_axis("move_left", "move_right")
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func update_animation():
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false
		
	match(player_state):
		state.IDLE:
			animated_sprite.play("idle")
		state.RUN:
			animated_sprite.play("run")
		state.ROLL:
			animated_sprite.play("roll")
		state.JUMP:
			animated_sprite.play("jump")
		state.FALL:
			animated_sprite.play("fall")
		state.ATTACK:
			animated_sprite.play("attack")


func _physics_process(_delta: float):
	if player_state != state.ROLL and player_state != state.ATTACK:
		get_input()

		if is_on_floor():
			if velocity.x == 0:
				player_state = state.IDLE
				label.text = "Idle"
			elif velocity.x != 0:
				player_state = state.RUN
				label.text = "Running"
				
			if Input.is_action_just_pressed("roll") and not dash.is_running():
				player_state = state.ROLL
				label.text = "Roll"
				#start_roll()

			if Input.is_action_just_pressed("jump"):
				velocity.y = JUMP_VELOCITY
				player_state = state.JUMP
				label.text = "Jumping"
			# elif Input.is_action_just_pressed("attack"):
				# Attacks here

		elif velocity.y < 0:
			player_state = state.JUMP
			label.text = "Jumping"
		else:
			player_state = state.FALL
			label.text = "Falling"
			
	elif player_state == state.ROLL:
		if dash.is_runnig():
			player_state = state.IDLE

	velocity.y += gravity * _delta

	update_animation()
	move_and_slide()

# Fonction pour gérer le début de la roulade de manière asynchrone
func start_roll():
	dash.start()  # Démarre l'animation de roulade
	# Attendez que l'animation se termine avant de remettre l'état à IDLE
	await(dash, "is_stopped")  # Attend que l'animation de roulade soit terminée
	player_state = state.IDLE
	label.text = "Idle"

	## Roll 1
	#if Input.is_action_just_pressed("roll") and is_on_floor() and not is_dashing:
		#is_dashing = true
		#dash_timer.start()
		#animated_sprite.play("roll")
		#if animated_sprite.flip_h == true:
			#velocity.x = -(SPEED * ROLL_VELOCITY)
		#elif animated_sprite.flip_h == false:
			#velocity.x = abs(SPEED * ROLL_VELOCITY)
	#
	## Movement
	#if Input.is_action_just_pressed("roll"):
		#is_dashing = true
		#dash_timer.start()
		#dash_effect.start()
		#
	#if is_dashing:
		#velocity.x = dash_direction * SPEED * DASH_SPEED
	#elif direction: velocity.x = direction * SPEED
	#else: velocity.x = move_toward(velocity.x, 0, SPEED)
	#
	## Flip the sprite
	#if direction < 0:
		#animated_sprite.flip_h = true
	#elif direction > 0:
		#animated_sprite.flip_h = false
	## animated_sprite.flip_h = direction < 0
#
	## Play animations
	#if is_on_floor():
		#if direction == 0:
			#animated_sprite.play("idle")
		#else:
			#animated_sprite.play("run")
	#else:
		#animated_sprite.play("jump")
#
	#move_and_slide()
#
#func _on_dash_timer_timeout() -> void:
	#is_dashing = false
	#dash_effect.stop()
#
#func _on_dash_effect_timeout() -> void:
	#animated_sprite.play("idle")

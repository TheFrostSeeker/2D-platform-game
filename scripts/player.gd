# EXTENDS =========================================================================================
extends CharacterBody2D

# SIGNALS =========================================================================================

# CONSTANTS =======================================================================================
const SPEED: float = 100.0
const JUMP_VELOCITY: float = -325.0
const ROLL_SPEED: float = 1.5

# DICTIONNRIES ====================================================================================
enum state {IDLE, RUN, ROLL, JUMP, FALL, ATTACK, HURT, DIE}

# STATICS =========================================================================================

# GLOBAL VARIABLES ================================================================================
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label
@onready var dash = $DurationTimer

# VARIABLES =======================================================================================
var player_state = state.IDLE
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_rolling = false

# CALLBACK FUNCTIONS ==============================================================================
func _init(): # Called when the object is first created. It now exists in the computer’s memory.
	pass

func _enter_tree(): # Called when the node enters the scene tree.
	pass

func _ready(): # Called when the node and its children are ready.
	pass

func _notification(what): # Called when the node receives a system notification.
	pass

func _input(event): # Called when the node receives an input event.
	pass

func _process(_delta: float) -> void: # Called every frame.
	pass

func _physics_process(_delta: float): # Called every physics frame (more precise).
	if player_state != state.ROLL and player_state != state.ATTACK:
		get_input()
		if is_on_floor():
			if velocity.x == 0:
				idle_state()
			elif velocity.x != 0:
				run_state()
			if Input.is_action_just_pressed("roll"):
				roll_state()
			if Input.is_action_just_pressed("jump"):
				jump_state()
			elif Input.is_action_just_pressed("attack"):
				attack_state()
		elif velocity.y > 0:
			fall_state()

	velocity.y += gravity * _delta

	update_animation()
	move_and_slide()

func _exit_tree(): # Called when the node exits the scene tree.
	pass

# INTERNAL FUNCTIONS ==============================================================================
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
		state.IDLE: animated_sprite.play("idle")
		state.RUN: animated_sprite.play("run")
		state.ROLL: animated_sprite.play("roll")
		state.JUMP: animated_sprite.play("jump")
		state.FALL: animated_sprite.play("fall")
		state.ATTACK: animated_sprite.play("attack")
		state.HURT: animated_sprite.play("hurt")
		state.DIE: animated_sprite.play("die")

func idle_state():
	player_state = state.IDLE
	label.text = "Idle"
	
func run_state():
	player_state = state.RUN
	label.text = "Running"

func roll_state():
	player_state = state.ROLL
	label.text = "Roll"
	dash.start()
	if animated_sprite.flip_h == true:
		velocity.x = -(SPEED * ROLL_SPEED)
	elif animated_sprite.flip_h == false:
		velocity.x = abs(SPEED * ROLL_SPEED)

func jump_state():
	velocity.y = JUMP_VELOCITY
	player_state = state.JUMP
	label.text = "Jumping"

func fall_state():
	player_state = state.FALL
	label.text = "Falling"

func attack_state():
	player_state = state.ATTACK
	label.text = "Attack"
	player_state = state.IDLE

# LINKED NODE FUNCTIONS ===========================================================================
func _on_duration_timer_timeout() -> void:
	player_state = state.IDLE 

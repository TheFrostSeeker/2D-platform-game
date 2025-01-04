extends CharacterBody2D

var current_state: State = null

const STATE_IDLE = preload("res://scripts/FSM/player/movement/idle.gd")
const STATE_RUN = preload("res://scripts/FSM/player/movement/run.gd")
const STATE_JUMP = preload("res://scripts/FSM/player/movement/jump.gd")
const STATE_ROLL = preload("res://scripts/FSM/player/movement/roll.gd")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var debug: Label = $debug

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	change_state("idle")  # Start with idle state

func change_state(new_state_name: String):
	var new_state_scene
	match new_state_name:
		"idle":
			debug.text = "Idle"
			new_state_scene = STATE_IDLE
		"run":
			debug.text = "Run"
			new_state_scene = STATE_RUN
		"jump":
			debug.text = "Jump"
			new_state_scene = STATE_JUMP
		"roll":
			debug.text = "Roll"
			new_state_scene = STATE_ROLL
		_ :
			print("Unknow state: ", new_state_name)
			return  # ignore state changement if unknown
	# Exit actual state
	if new_state_scene == null:
		print("erreur, la state ", new_state_name, " est introuvable")
		return
		
	if current_state != null:
		current_state.exit()
		current_state.queue_free()

	# Initialise le nouvel état
	current_state = new_state_scene.new()
	add_child(current_state)
	current_state.enter()

func _process(delta):
	if current_state != null:
		current_state.update(delta)  # Delegates updates to the current state

func _physics_process(delta):
	# Add gravity
	velocity.y += gravity * delta
	
	move_and_slide()
	if velocity.x > 0:
		animated_sprite.flip_h = false  # Sprite look right
	elif velocity.x < 0:
		animated_sprite.flip_h = true   # Sprite look left

extends CharacterBody2D

#region Player variables
# Nodes
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var debug: Label = $debug
@onready var roll_cooldown: Timer = $FiniteStateMachine/Roll/RollCooldown

# Physics  var
@export var acceleration: int = 30
@export var deceleration: int = 25
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var move_direction_x: float = 0
var facing: int = 1
var pause: int = 0

# Run const
@export var run_speed: float = 150

# Jump consts
@export var jump_speed: int = -300
@export var max_jumps: int = 1
var jumps: int = 0

# Roll consts
@export var max_rolls: int = 1
var roll_speed: float = run_speed * 1.5
var rolls: int = 0
var roll_direction: int = 1

# Inputs variables
var key_left: bool = false
var key_right: bool = false
var key_jump: bool = false
var key_jump_pressed: bool = false
var key_roll: bool = false
var key_pause: bool = false

# Finite State Machine
var fsm_current_state: State = null
var fsm_previous_state: State = null
#endregion

#region Main loop functions
func _ready():
	# Initialise FSM
	for state in fsm.get_children():
		state.states = fsm
		state.player = self
	fsm_previous_state = fsm.fall
	fsm_current_state = fsm.fall

func _draw():
	fsm_current_state.draw()

func _physics_process(delta: float) -> void:
	# Get input
	get_input_states()
		
	# Update current state
	fsm_current_state.update(delta)
	
	# Commit movement
	move_and_slide()

func change_state(new_state):
	if new_state != null:
		fsm_previous_state = fsm_current_state
		fsm_current_state = new_state
		fsm_previous_state.exit_state()
		fsm_current_state.enter_state()
		print("State change from: " + fsm_previous_state.state_name + " to " + fsm_current_state.state_name)

#endregion

#region Custom functions
func get_input_states():
	key_left = Input.is_action_pressed("move_left")
	key_right = Input.is_action_pressed("move_right")
	key_jump = Input.is_action_pressed("jump")
	key_jump_pressed = Input.is_action_just_pressed("jump")
	key_roll = Input.is_action_pressed("roll")
	key_pause = Input.is_action_just_pressed("pause")
	
	if key_right: facing = 1
	if key_left: facing = -1
	
func horizontal_movement(Acceleration: float = acceleration, Deceleration: float = deceleration):
	move_direction_x = Input.get_axis("move_left", "move_right")
	if move_direction_x != 0:
		velocity.x = move_toward(velocity.x, move_direction_x * run_speed, Acceleration)
	else:
		velocity.x = move_toward(velocity.x, move_direction_x * run_speed, Deceleration)
	
func apply_gravity(delta, Gravity: float = gravity):
	if not is_on_floor():
		velocity.y += Gravity * delta 
	
func pause_game():
	if key_pause:
		key_pause = true
		pause += 1
		Engine.time_scale = 0
	elif pause == 2:
		key_pause = false
		pause = 0
		Engine.time_scale = 1
	
func handle_jump():
	if key_jump_pressed and jumps < max_jumps and is_on_floor():
		velocity.y = jump_speed
		jumps += 1
		rolls += 1
		change_state(fsm.jump)
	
func handle_fall():
	if not is_on_floor():
		change_state(fsm.fall)
	
func handle_land():
	jumps = 0
	rolls = 0
	if is_on_floor():
		change_state(fsm.idle) 
	
func handle_roll():
	if key_roll and rolls < max_rolls and is_on_floor():
		jumps += 1
		rolls += 1
		change_state(fsm.roll)
	
func handle_flip():
	sprite.flip_h = facing < 1

#endregion

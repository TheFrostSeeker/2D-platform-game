extends CharacterBody2D

#region Player variables
# Nodes
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var collision: CollisionShape2D = $HurtBox/CollisionShape2D
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var dash_cooldown: Timer = $FiniteStateMachine/Dash/DashCooldown
@onready var death_timer: Timer = $DeathTimer
@onready var enemy: CharacterBody2D = $/root/Hub/Enemies/RedSlime

# Physics var
@export var acceleration: int = 30
@export var deceleration: int = 25
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var move_direction_x: float = 0
var facing: int = 1
var direction: int = 1
var pause: int = 0

# Player var
@export var max_health: int = 50
@export var health: int = 50
@export var damage: int = 10

# Run var
@export var run_speed: float = 150

# Jump var
@export var jump_speed: int = -300
@export var max_jumps: int = 1
var jump_number: int = 0
var jump_active: bool = false

# Dash var
var dash_speed: float = run_speed * 1.5
var can_dash: bool = true
var dash_active: bool = false

# Attack var
@export var attack_damage: int = 1
var can_attack: bool = true
var attack_active: bool = false

# Death var
var is_dying: bool = false

# Inputs variables
var key_left: bool = false
var key_right: bool = false
var key_jump: bool = false
var key_jump_pressed: bool = false
var key_dash: bool = false
var key_pause: bool = false
var key_attack: bool = false

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
		#print("State change from: " + fsm_previous_state.state_name + " to " + fsm_current_state.state_name)

#endregion

#region Custom functions
func get_input_states():
	key_left = Input.is_action_pressed("move_left")
	key_right = Input.is_action_pressed("move_right")
	key_jump = Input.is_action_pressed("jump")
	key_jump_pressed = Input.is_action_just_pressed("jump")
	key_dash = Input.is_action_pressed("dash")
	key_pause = Input.is_action_just_pressed("pause")
	key_attack = Input.is_action_just_pressed("attack")
	
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
	if key_jump_pressed and jump_number < max_jumps and is_on_floor():
		velocity.y = jump_speed
		jump_number += 1
		change_state(fsm.jump)
	
func handle_fall():
	if not is_on_floor():
		change_state(fsm.fall)
	
func handle_land():
	if is_on_floor():
		change_state(fsm.idle) 
	
func handle_counter_reset():
	jump_number = 0
	jump_active = false
	
func handle_dash():
	if key_dash and can_dash and is_on_floor():
		direction = -1 if facing < 1 else 1
		dash_active = true
		can_dash = false
		change_state(fsm.dash)
	
func handle_attack():
	if key_attack and is_on_floor():
		change_state(fsm.attack_1)
	
func end_of_dash():
	dash_active = false
	
func ready_for_attack():
	can_attack = true

func handle_flip():
	sprite.flip_h = facing < 1

func handle_ctrl_flip():
	if animation.is_playing:
		pass
	else:
		sprite.flip_h = facing < 1

func player_death():
	if not is_dying:
		is_dying = true
		death_timer.start()
		Engine.time_scale = 0.5

func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

#endregion


func _on_hit_box_area_entered(body: Node2D) -> void:
	enemy.health -= damage
	print("enemy damaged")
	print(enemy.health + damage)
	if enemy.health <= 0:
		enemy.enemy_death()

extends Node2D
class_name State

signal Transitioned

# Imports
@onready var player: CharacterBody2D
@onready var sprite: AnimatedSprite2D 
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Bool
@onready var can_jump: bool = true
@onready var can_roll: bool = true

# Float
@onready var speed: float = 100.0
@onready var roll_velocity: float = 1.5
@onready var roll_control: float = 100.0

func _ready():
	set_physics_process(false)

func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func update(_delta):
	pass

func transition():
	pass

func _physics_process(_delta):
	transition()

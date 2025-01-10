extends CharacterBody2D

const SPEED = 60

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $/root/Hub/Player

@export var damage: int = 5
@export var health: int = 30

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	position.x += direction * SPEED * delta
	velocity.y += gravity * delta
	move_and_slide()

func enemy_death():
	queue_free()

func _on_hurt_box_area_entered(body: Node2D) -> void:
	player.health -= damage
	print("player damaged")
	print(player.health + damage)
	if player.health <= 0:
		player.player_death()

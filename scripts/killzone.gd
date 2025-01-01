extends Area2D

@onready var timer = $Timer

func _on_body_entered(body:Node2D) -> void:
	print("You died !")
	Engine.time_scale = 0.5
	timer.start()
	var collision_shape = body.get_node("CollisionShape2D")
	if collision_shape:
		collision_shape.queue_free()
	else:
		var actual_node = get_node(collision_shape)
		print("Erreur : " + actual_node + " introuvable sur " + body.name)
		Engine.time_scale = 0


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	print(get_tree())
	get_tree().reload_current_scene()

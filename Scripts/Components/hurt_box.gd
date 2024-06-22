extends Area2D
class_name HurtBox

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.respawn()

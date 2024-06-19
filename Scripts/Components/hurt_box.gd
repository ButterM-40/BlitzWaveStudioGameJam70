extends Area2D
class_name HurtBox

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var is_active: bool = true:
	set(value):
		is_active = value
		if collision_shape_2d:
			collision_shape_2d.set_deferred("disabled", not is_active)

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Health:
			child.take_damage()
			break

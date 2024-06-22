extends Area2D
class_name HurtBox

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func set_disabled(disabled: bool) -> void:
	collision_shape_2d.set_deferred("disabled", disabled)

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Health:
			child.take_damage()
			break

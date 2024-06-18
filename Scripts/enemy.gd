extends RigidBody2D
class_name Enemy

func _on_died() -> void:
	# Death logic
	call_deferred("queue_free")

func _on_pushed(force: Vector2) -> void:
	apply_impulse(force)

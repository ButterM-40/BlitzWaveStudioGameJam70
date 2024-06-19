extends RigidBody2D
class_name Totem

func _on_died() -> void:
	# Death logic
	call_deferred("queue_free")

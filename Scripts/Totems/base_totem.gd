extends RigidBody2D
class_name Totem

@export var snap: Vector2 = Vector2(16, 16)

func _ready() -> void:
	position = position.snapped(snap)
	freeze = true
	get_tree().create_timer(.05).timeout.connect(unfreeze)

func unfreeze() -> void:
	freeze = false

func _on_died() -> void:
	# Death logic
	call_deferred("queue_free")

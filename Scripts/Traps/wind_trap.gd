extends Area2D

@export var strength: float

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Pushable:
			child.pushed.emit(Vector2.LEFT * strength)

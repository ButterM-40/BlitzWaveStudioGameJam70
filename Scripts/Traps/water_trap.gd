extends Trap
class_name WaterTrap

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Aquatic:
			child.dived.emit()
			break

func _on_body_exited(body: Node2D) -> void:
	for child in body.get_children():
		if child is Aquatic:
			child.surfaced.emit()
			break


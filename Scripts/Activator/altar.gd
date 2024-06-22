extends Activator
class_name Altar

@export var required_totem: Constants.Character

func _on_body_entered(body: Node2D) -> void:
	if body.type == required_totem:
		trigger()

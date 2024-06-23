extends Activator
class_name Altar

@export var required_totem: Constants.TotemType

func _on_body_entered(body: Node2D) -> void:
	print('entered:', body)
	if body.type == required_totem:
		activate()

extends Node

signal jump_pressed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		jump_pressed.emit()

func get_horizontal_input() -> float:
	var left: float = Input.get_action_strength("Left")
	var right: float = Input.get_action_strength("Right")
	return left - right

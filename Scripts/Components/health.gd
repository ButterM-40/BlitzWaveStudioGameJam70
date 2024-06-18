extends Node2D
class_name Health

# The death logic could be in this class
# But I don't know if the death will be generic between every entity
signal died # :(

@export var lives: int = 1

func take_damage() -> void:
	lives -= 1
	if lives <= 0:
		died.emit()

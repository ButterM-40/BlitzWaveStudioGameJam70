extends Area2D
class_name Activator

signal triggered()

func trigger() -> void:
	triggered.emit()

func reset() -> void:
	pass

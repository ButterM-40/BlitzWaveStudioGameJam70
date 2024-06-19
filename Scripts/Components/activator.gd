extends Area2D
class_name Activator

@export var activatable_objects: Array[Activatable]

func activate() -> void:
	for object in activatable_objects:
		object.activate()

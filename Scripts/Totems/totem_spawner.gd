extends Node2D
class_name TotemSpawner

@export var totems: Array[PackedScene]

func spawn_totem(character: Constants.Character, new_position: Vector2) -> void:
	var totem: Totem = totems[character].instantiate()
	totem.position = new_position
	add_child(totem)

func clear_totem() -> void:
	for totem in get_children():
		totem.queue_free()

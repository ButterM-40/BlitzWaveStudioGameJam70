extends Node2D

@export var player_node: Player

var menu = preload("res://Scenes/settings.tscn").instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var game_paused = player_node.game_paused

	if Input.get_action_strength('Menu') && !game_paused:
		get_tree().root.add_child(menu)
		player_node.game_paused = true
	elif get_tree().root.has_node('Settings') && !game_paused:
		get_tree().root.remove_child(get_tree().root.get_node('Settings'))
		
	pass

extends Node2D


var menu = preload('res://settings.tscn').instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var game_paused = get_node('../Player').game_paused

	if Input.get_action_strength('Menu') && !game_paused:
		get_tree().root.add_child(menu)
		get_node('../Player').game_paused = true
	elif get_tree().root.has_node('Settings') && !game_paused:
		get_tree().root.remove_child(get_tree().root.get_node('Settings'))
		
	pass

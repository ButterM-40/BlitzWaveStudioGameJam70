extends Button

func _on_pressed():
	$music.play()
	get_tree().reload_current_scene()

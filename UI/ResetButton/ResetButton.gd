extends Button

func _process(delta):
	if Input.is_action_just_pressed('Reset'):
		$music.play()
		get_tree().reload_current_scene()
	pass

func _on_pressed():
	$music.play()
	get_tree().reload_current_scene()

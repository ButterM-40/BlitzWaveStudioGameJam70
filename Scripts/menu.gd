extends Control


func _on_play_pressed():
	get_tree().root.get_node('Testing/---- Player ----/Player').game_paused = false
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()

func _on_option_pressed():
	pass # Replace with function body.

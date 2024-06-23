extends Control

@onready var level_select = preload("res://UI/LevelSelector/LevelSelectScreen.tscn")
@onready var buttonPlay = $Music/ButtonPress
# Called when the node enters the scene tree for the first time.
func _ready():
	if !FileAccess.file_exists("user://level_unlockable.save"):
		var save_game = FileAccess.open("user://level_unlockable.save", FileAccess.WRITE)
		save_game.store_var({
			"level_1": true,
			"level_2": false,
			"level_3": false,
			"level_4": false,
			"level_5": false,
			"level_6": false,
			"level_7": false,
			"level_8": false,
			"level_9": false,
			"level_10": false,
			"level_11": false,
			"level_12": false
		})
		save_game.close()

	pass # Replace with function body.


func _on_play_pressed():
	buttonPlay.play()
	await(buttonPlay.finished)
	get_tree().change_scene_to_packed(level_select)
	pass


func _on_quit_pressed():
	buttonPlay.play()
	await(buttonPlay.finished)
	get_tree().quit()
	pass
	


func _on_options_pressed():
	buttonPlay.play()
	$OptionsNode.visible = true
	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_back_option_pressed():
	buttonPlay.play()
	$OptionsNode.visible = false
	pass # Replace with function body.

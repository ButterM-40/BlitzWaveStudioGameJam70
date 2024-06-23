extends Button

@onready var level_select = preload("res://UI/LevelSelector/LevelSelectScreen.tscn")
@export var ButtonPress = AudioStreamPlayer2D
func _on_options_pressed():
	ButtonPress.play
	$OptionsNodeSuperDuper.visible = true
	pass # Replace with function body.


func _on_quit_pressed():
	$MarginContainer.visible = false
	get_tree().change_scene_to_packed(level_select)
	pass # Replace with function body.


func _on_play_pressed():
	ButtonPress.play
	$MarginContainer.visible = false
	pass # Replace with function body.
	
func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_back_option_pressed():
	ButtonPress.play
	$OptionsNodeSuperDuper.visible = false
	pass # Replace with function body.


func _on_pressed():
	$MarginContainer.visible = true
	pass # Replace with function body.

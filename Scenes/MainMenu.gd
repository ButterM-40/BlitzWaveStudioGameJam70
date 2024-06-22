extends Control

@onready var level_select = preload("res://UI/LevelSelector/LevelSelectScreen.tscn")
@onready var buttonPlay = $Music/ButtonPress
# Called when the node enters the scene tree for the first time.
func _ready():
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
	

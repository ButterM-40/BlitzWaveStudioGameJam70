extends Node2D

const LEVEL_BTN = preload("res://UI/LevelSelector/LvlBtn.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file('res://Scenes/MainMenu.tscn')

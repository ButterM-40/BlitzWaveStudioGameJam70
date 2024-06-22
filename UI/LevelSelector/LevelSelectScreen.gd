extends Control

const LEVEL_BTN = preload("res://UI/LevelSelector/LvlBtn.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path) -> void:
	var dir = DirAccess.open(path)
	print(dir.get_files())
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		for file_n in dir.get_files():
			print(file_n)
			create_level_btn('%s/%s' % [dir.get_current_dir(), file_name], file_name)
		dir.list_dir_end()
		#while file_name != "":
		#	print(file_name)
		#	create_level_btn('%s/%s' % [dir.get_current_dir(), file_name], file_name)
		#	file_name = dir.get_next()
		#
	else:
		print('SomethingWrong')
		
func create_level_btn(lvl_path: String, lvl_name: String) ->void :
	var btn = LEVEL_BTN.instantiate()
	btn.text = lvl_name.trim_suffix('.tscn').replace('_', ' ')
	btn.level_path = lvl_path
	grid.add_child(btn)	

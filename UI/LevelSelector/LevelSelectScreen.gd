extends Control

const LEVEL_BTN = preload("res://UI/LevelSelector/LvlBtn.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer
var save_path = "user://level_unlockable.save"
var save_dict = {}
func _ready() -> void:
	
	save_dict = save()
	#save_level()
	#load_level()
	#update_level("level_2")
	#print("============")
	get_levels(dir_path)
	
	#print(save_dict)
	#print("===================")
func get_levels(path) -> void:
	load_level()
	var dir = DirAccess.open(path)

	#print(dir.get_files())
  
	if dir:
		dir.list_dir_begin()
		var file_name
		
		for file_n in dir.get_files():
			file_name = file_n

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
	var fileName = lvl_name.trim_suffix('.tscn')
	print(save_dict)
	
	if fileName not in save_dict:
		save_dict[fileName] = false
	
	#if save_dict[fileName]:
	#	var btn = LEVEL_BTN.instantiate()
	#	btn.text = lvl_name.trim_suffix('.tscn').trim_suffix('.remap').replace('_', ' ')
	#	btn.level_path = lvl_path
	#	grid.add_child(btn)	
	#if lvl_name.trim_suffix('.tscn').trim_suffix('.remap').replace('_', ' ') == "level 1":
	#	var btn = LEVEL_BTN.instantiate()
	#	btn.text = lvl_name.trim_suffix('.tscn').replace('_', ' ')
	#	btn.level_path = lvl_path
	#	grid.add_child(btn)	
	var btn = LEVEL_BTN.instantiate()
	btn.text = lvl_name.trim_suffix('.tscn').trim_suffix('.remap').replace('_', ' ')
	btn.text = btn.text.trim_suffix('.tscn')
	btn.level_path = lvl_path.trim_suffix('.remap')
	print("Name of path: " + lvl_path)
	print("=====================")
	grid.add_child(btn)	
	
func update_level(level_name) -> void:
	level_name = level_name.trim_suffix('.tscn')
	var boolNextInLineTrue = false
	for level in save_dict:
		if level == level_name:
			boolNextInLineTrue = true
		elif boolNextInLineTrue:
			save_dict[level] = true
			save_level()
			break
			
	pass

func save_level() ->void:
	var save_game = FileAccess.open(save_path, FileAccess.WRITE)
	save_game.store_var(save_dict)
	save_game.close()
	pass
func load_level():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		save_dict = file.get_var()
		file.close()
	pass
	
func save():
	#Default Initial Save
	save_dict = {
		"The_Start": true,	
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
	}
	return save_dict




extends Area2D

var save_path = "user://level_unlockable.save"

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(FileAccess.file_exists(save_path))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print(get_tree().root.get_children())

	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var level = get_tree().current_scene.scene_file_path
		level = level.substr(26, 1)
		
		var save = file.get_var()
		save['level_' + level] = true

		var file_w = FileAccess.open(save_path, FileAccess.WRITE)
		file_w.store_var(save)

		file.close()
		file_w.close()
		if ResourceLoader.exists('res://Scenes/Levels/level_'+ str(int(level) + 1) + '.tscn'):
			get_tree().change_scene_to_file('res://Scenes/Levels/level_'+ str(int(level) + 1) + '.tscn')
		else:
			get_tree().change_scene_to_file('res://UI/LevelSelector/LevelSelectScreen.tscn')
	pass # Replace with function body.

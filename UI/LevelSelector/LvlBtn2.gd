extends Button

@export_file var level_path
@onready var music = $Play
var original_size := scale
var grow_size := Vector2(scale.x + .1, scale.y + .1)

func _on_mouse_entered():
	grow_btn(grow_size, .1)


func _on_mouse_exited():
	grow_btn(original_size, .1)

func grow_btn(end_size: Vector2, duration:float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)



func _on_pressed() -> void:
	if level_path == null:
		print("Level_Path is NULL")
		return
	music.play()
	await(music.finished)	
	get_tree().change_scene_to_file(level_path)

extends StaticBody2D
class_name Activatable

@export var activators: Array[Activator]
@export var fade_direction: Orientation

@onready var fade_timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var activator_triggered: int = 0
var is_activated: bool = false

func activate() -> void:
	fade()
	fade_timer.start()

func reset() -> void:
	unfade()
	activator_triggered = 0
	is_activated = false
	collision_shape_2d.set_deferred("disabled", false)

func fade() -> void:
	var duration: float = fade_timer.wait_time
	var final_pos: Vector2 = sprite_2d.position
	match fade_direction:
		HORIZONTAL:
			var width: int = sprite_2d.texture.get_width()
			final_pos.x -= width
		VERTICAL:
			var height: int = sprite_2d.texture.get_height()
			final_pos.y -= height
	create_tween().tween_property(sprite_2d, "position", final_pos, duration)

func unfade() -> void:
	var duration: float = fade_timer.wait_time
	var final_pos: Vector2 = sprite_2d.position
	match fade_direction:
		HORIZONTAL:
			var width: int = 0
			if is_activated:
				width = sprite_2d.texture.get_width()
			final_pos.x += width
		VERTICAL:
			var height: int = 0
			if is_activated:
				height = sprite_2d.texture.get_height()
			final_pos.y += height
	create_tween().tween_property(sprite_2d, "position", final_pos, duration)

func _on_activator_triggered() -> void:
	activator_triggered += 1
	if activator_triggered == activators.size():
		activate()
		is_activated = true

func _on_timer_timeout() -> void:
		collision_shape_2d.set_deferred("disabled", true)

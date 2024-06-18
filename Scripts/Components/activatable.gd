extends StaticBody2D
class_name Activatable

@export var fade_direction: Orientation

@onready var fade_timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func activate() -> void:
	fade()
	fade_timer.start()

func fade() -> void:
	var duration: float = fade_timer.wait_time
	var final_pos: Vector2 = sprite_2d.position
	match fade_direction:
		HORIZONTAL: 
			final_pos.x -= sprite_2d.texture.get_width()
		VERTICAL:
			final_pos.y -= sprite_2d.texture.get_height()
	create_tween().tween_property(sprite_2d, "position", final_pos, duration)

func _on_timer_timeout() -> void:
	collision_shape_2d.disabled = true

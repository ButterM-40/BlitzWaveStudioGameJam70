extends Area2D
class_name FlameTrap

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_box: HurtBox = $HurtBox

var adjacent_flame_trap: Array[FlameTrap] = []
var is_extinguished: bool = false

func extinguish() -> void:
	is_extinguished = true
	animated_sprite_2d.animation = "extinguished"
	hurt_box.is_active = false
	for flame_trap in adjacent_flame_trap:
		if not flame_trap.is_extinguished:
			flame_trap.extinguish()

func _on_detector_body_entered(body: Node2D) -> void:
	if body is TurtleTotem:
		extinguish()

func _on_adjacent_flame_trap_detector_area_entered(area: Area2D) -> void:
	if area is FlameTrap:
		adjacent_flame_trap.append(area)
extends Node2D
class_name Health

# The death logic could be in this class
# But I don't know if the death will be generic between every entity
signal died # :(

@export var lives: int = 1

@onready var recovery_timer: Timer = $RecoveryTimer
var is_recovering: bool = false

func take_damage(amount: int = 1) -> void:
	if is_recovering:
		return
	lives -= amount
	if lives <= 0:
		died.emit()
	is_recovering = true
	recovery_timer.start()

func die() -> void:
	lives = 0
	died.emit()

func _on_recovery_timer_timeout() -> void:
	is_recovering = false

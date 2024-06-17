extends Area2D
class_name JumpBoostAbility

@export var modifier: float = 1.0
const BASE_MODIFIER: float = 1.0

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.jump_modifier = modifier

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.jump_modifier = BASE_MODIFIER

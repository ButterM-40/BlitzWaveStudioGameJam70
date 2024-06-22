extends Area2D
class_name JumpBoost

const IMPROVED_JUMP_HEIGHT_MODIFIER: float = 1.5

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.jump_height *= IMPROVED_JUMP_HEIGHT_MODIFIER

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.jump_height /= IMPROVED_JUMP_HEIGHT_MODIFIER

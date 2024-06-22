extends Area2D
class_name JumpBoostAbility

const ABILITY_VELOCITY: float = -1750.0

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.current_jump_velocity = ABILITY_VELOCITY

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.current_jump_velocity = body.JUMP_VELOCITY

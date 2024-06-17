extends Area2D
class_name HurtBox

func _on_body_entered(body: Node2D) -> void:
	body.call_deferred("queue_free")

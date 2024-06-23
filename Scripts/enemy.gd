extends RigidBody2D
class_name Enemy

@export var speed: float
@export var starting_direction: StartingDirection = StartingDirection.LEFT
var direction: Vector2 = Vector2.LEFT

enum StartingDirection {
	LEFT,
	RIGHT
}

func _physics_process(delta: float) -> void:
	var motion: Vector2 = direction * speed * delta
	var kb: KinematicCollision2D = move_and_collide(motion)
	if kb && kb.get_normal() != Vector2.UP:
		direction = -1 * direction
		$AnimatedSprite2D.scale.x *= -1

func _on_died() -> void:
	# Death logic
	call_deferred("queue_free")

func _on_pushed(force: Vector2) -> void:
	apply_impulse(force)

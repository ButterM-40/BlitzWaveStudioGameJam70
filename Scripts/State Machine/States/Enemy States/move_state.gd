extends State
class_name MoveState

@export var body: PhysicsBody2D
@export var speed: float

const DIRECTION: Vector2 = Vector2.RIGHT

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(delta: float) -> void:
	var kb: KinematicCollision2D = body.move_and_collide(DIRECTION * speed * delta)
	if kb:
		speed = -speed

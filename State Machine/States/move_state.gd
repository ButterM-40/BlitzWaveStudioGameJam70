extends State
class_name MoveState

@export var speed: float

var body: PhysicsBody2D
const DIRECTION: Vector2 = Vector2.RIGHT

func _ready() -> void:
	body = get_parent() as PhysicsBody2D

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(delta: float) -> void:
	var kb: KinematicCollision2D = body.move_and_collide(DIRECTION * speed * delta)
	if kb:
		speed = -speed

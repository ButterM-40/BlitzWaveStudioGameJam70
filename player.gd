extends CharacterBody2D

@export var player_sprite: AnimatedSprite2D
@onready var initial_sprite_scale = player_sprite.scale
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state = PlayerState.IDLE
enum PlayerState{
	IDLE,
	WALK
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	var horizontal_input = (
		
		Input.get_action_strength("Left")
		- Input.get_action_strength("Right")
	)
	 #Input.get_vector("Left", "Right", 0, 0)
	velocity.x = horizontal_input * SPEED
	move_and_slide()
	handle_movement_state()
	face_movement_direction(horizontal_input)
	
func face_movement_direction(horizontal_input):
	if not is_zero_approx(horizontal_input): 
		if horizontal_input < 0:
			player_sprite.scale = Vector2(-initial_sprite_scale.x, initial_sprite_scale.y)
		else:
			player_sprite.scale = initial_sprite_scale
func handle_movement_state():
	if is_zero_approx(velocity.x):
		state = PlayerState.IDLE
	
	elif not is_zero_approx(velocity.x):
		state = PlayerState.WALK
	match state:
		PlayerState.IDLE:
			player_sprite.play("idle")
		PlayerState.WALK:
			player_sprite.play("walk")
		

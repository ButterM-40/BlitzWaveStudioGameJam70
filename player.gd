extends CharacterBody2D

@export var player_sprite: AnimatedSprite2D
@onready var initial_sprite_scale = player_sprite.scale
const SPEED = 300.0
const JUMP_VELOCITY = -2000.0
var state = PlayerState.IDLE
enum PlayerState{
	IDLE,
	WALK
}
var current_jump_velocity = JUMP_VELOCITY

var respawn_point
var game_paused = false

var character = Character.BIDZIIL
enum Character {
	BIDZIIL,
	GAAGII,
	AHULI,
	TATONGA
}

var bidziil_cursor = preload("res://Cursors/cursorRedArrow.png")
var bidziil_cursor_hand = preload("res://Cursors/cursorRedHand.png")

var gaagii_cursor = preload("res://Cursors/cursorGreenArrow.png")
var gaagii_cursor_hand = preload("res://Cursors/cursorGreenHand.png")

var ahuli_cursor = preload("res://Cursors/cursorYellowArrow.png")
var ahuli_cursor_hand = preload("res://Cursors/cursorYellowHand.png")

var tatonga_cursor = preload("res://Cursors/cursorBlueArrow.png")
var tatonga_cursor_hand = preload("res://Cursors/cursorBlueHand.png")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	respawn_point = get_node('../../RespawnPoint')
	
	if character == Character.BIDZIIL:
		Input.set_custom_mouse_cursor(bidziil_cursor)
	elif character == Character.GAAGII:
		Input.set_custom_mouse_cursor(gaagii_cursor)
	elif character == Character.AHULI:
		Input.set_custom_mouse_cursor(ahuli_cursor)
	elif character == Character.TATONGA:
		Input.set_custom_mouse_cursor(tatonga_cursor)

func _process(delta):
	if character == Character.BIDZIIL:
		Input.set_custom_mouse_cursor(bidziil_cursor)
	elif character == Character.GAAGII:
		Input.set_custom_mouse_cursor(gaagii_cursor)
	elif character == Character.AHULI:
		Input.set_custom_mouse_cursor(ahuli_cursor)
	elif character == Character.TATONGA:
		Input.set_custom_mouse_cursor(tatonga_cursor)
		
	pass

func _physics_process(_delta):
	var horizontal_input = (
		
		Input.get_action_strength("Left")
		- Input.get_action_strength("Right")
	)

	var grounded = false

	#for i in get_node('GroundedCollider').get_overlapping_bodies():
	#	if i.has_meta('TotemType'):
	#		if i.get_meta('TotemType') == 'Turtle':
	#			continue
	
	var vertical_input = 0

	if is_on_floor():
		vertical_input = Input.get_action_strength("Jump")
	
	if !game_paused:
		velocity.x = horizontal_input * SPEED

		velocity.y += vertical_input * current_jump_velocity 
		velocity.y += gravity

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

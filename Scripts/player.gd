extends CharacterBody2D
class_name Player
@export var player_sprite: AnimatedSprite2D
@onready var initial_sprite_scale = player_sprite.scale
const SPEED = 300.0
const JUMP_VELOCITY = -1250.0
var current_jump_velocity = JUMP_VELOCITY

var state = PlayerState.IDLE
enum PlayerState {
	IDLE,
	WALK,
	JUMP
}

var respawn_point
@onready var respawn_timer = $RespawnTimer
var game_paused = false

var character = Character.BIDZIIL
enum Character {
	BIDZIIL,
	GAAGII,
	AHULI,
	TATONGA
}
var bidziil_cursor = preload ("res://Art/Cursors/cursorRedArrow.png")
var bidziil_cursor_hand = preload ("res://Art/Cursors/cursorRedHand.png")

var gaagii_cursor = preload ("res://Art/Cursors/cursorGreenArrow.png")
var gaagii_cursor_hand = preload ("res://Art/Cursors/cursorGreenHand.png")

var ahuli_cursor = preload ("res://Art/Cursors/cursorYellowArrow.png")
var ahuli_cursor_hand = preload ("res://Art/Cursors/cursorYellowHand.png")

var tatonga_cursor = preload ("res://Art/Cursors/cursorBlueArrow.png")
var tatonga_cursor_hand = preload ("res://Art/Cursors/cursorBlueHand.png")

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

func _process(_delta):
	var ambience_player = get_node('Audio/Ambience')

	if !ambience_player.playing:
		ambience_player.playing = true

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

	var vertical_input = 0

	if is_on_floor():
		vertical_input = Input.get_action_strength("Jump")

		if vertical_input > 0:
			jump_sound()
	
	if !game_paused:
		velocity.x = horizontal_input * SPEED

		velocity.y += vertical_input * current_jump_velocity
		velocity.y += gravity

		move_and_slide()
		handle_movement_state()
		face_movement_direction(horizontal_input)

func foot_steps():
	var sound_player = get_node('Audio/GrassFootsteps')
	
	if !sound_player.playing:
		var num = randi_range(1, 8)

		var audio_stream = load('res://Sound/Footsteps/GrassStep_' + str(num) + '.wav')

		sound_player.set_stream(audio_stream)
		
		sound_player.playing = true
	pass

func jump_sound():
	var sound_player = get_node('Audio/Jump')
	
	var num = randi_range(1, 4)

	var audio_stream = load('res://Sound/Jumps/Jump_' + str(num) + '.wav')

	sound_player.set_stream(audio_stream)
	
	sound_player.playing = true
	pass

func face_movement_direction(horizontal_input):
	if not is_zero_approx(horizontal_input):
		if horizontal_input < 0:
			player_sprite.scale = Vector2( - initial_sprite_scale.x, initial_sprite_scale.y)
		else:
			player_sprite.scale = initial_sprite_scale

func handle_movement_state():
	
	if is_zero_approx(velocity.x)&&is_on_floor():
		state = PlayerState.IDLE
	
	elif not is_zero_approx(velocity.x)&&is_on_floor():
		state = PlayerState.WALK
	else:
		state = PlayerState.JUMP
	match state:
		PlayerState.IDLE:
			player_sprite.play("idle")
		PlayerState.WALK:
			player_sprite.play("walk")
			foot_steps()
		PlayerState.JUMP:
			player_sprite.play("jump")

func respawn():
	if respawn_timer.time_left > 0:
		return
		
	var ui_switch = get_node('../../UI Totem Switch')

	var sound_player = get_node('Audio/Death')
	var audio_stream

	var select_sound_player = get_node('Audio/Select')
	var rand_num = randi_range(1, 3)
	var select_audio_stream
	
	var totem
	match character:
		Character.BIDZIIL:
			totem = ui_switch.totem_array[0].instantiate()
			audio_stream = load('res://Sound/Death/BearDeath.wav')
			select_audio_stream = load('res://Sound/Select/BearSelect_' + str(rand_num) + '.wav')
		Character.GAAGII:
			totem = ui_switch.totem_array[1].instantiate()
			audio_stream = load('res://Sound/Death/FrogDeath.wav')
			select_audio_stream = load('res://Sound/Select/FrogSelect_' + str(rand_num) + '.wav')
		Character.AHULI:
			totem = ui_switch.totem_array[2].instantiate()
			audio_stream = load('res://Sound/Death/OwlDeath.wav')
			select_audio_stream = load('res://Sound/Select/OwlSelect_' + str(rand_num) + '.wav')
		Character.TATONGA:
			totem = ui_switch.totem_array[3].instantiate()
			audio_stream = load('res://Sound/Death/TurtleDeath.wav')
			select_audio_stream = load('res://Sound/Select/TurtleSelect_' + str(rand_num) + '.wav')

	sound_player.set_stream(audio_stream)
	select_sound_player.set_stream(select_audio_stream)
	
	sound_player.playing = true
	select_sound_player.playing = true

	if ui_switch.scene_array.size() > 1:
		if ui_switch.scene_array[1].instantiate().name == 'BearUi':
			character = Character.BIDZIIL
			player_sprite.sprite_frames = ui_switch.animation_array[0]
		elif ui_switch.scene_array[1].instantiate().name == 'FrogUi':
			character = Character.GAAGII
			player_sprite.sprite_frames = ui_switch.animation_array[2]
		elif ui_switch.scene_array[1].instantiate().name == 'EagleUi':
			player_sprite.sprite_frames = ui_switch.animation_array[1]
			character = Character.AHULI
		elif ui_switch.scene_array[1].instantiate().name == 'TurtleUi':
			character = Character.TATONGA
			player_sprite.sprite_frames = ui_switch.animation_array[3]
	
	totem.position = position + Vector2(0, -50)
	get_parent().add_child(totem)
	position = respawn_point.position

	ui_switch.removeCurrentTotem()
	
	respawn_timer.start()

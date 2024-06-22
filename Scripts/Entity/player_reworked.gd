extends CharacterBody2D
class_name Player

enum PlayerState {
	IDLE,
	WALK,
	JUMP,
	FALL,
	PUSHED,
	DEAD
}

@export var sprite_frames: Array[SpriteFrames]
@export_category("Settings")
@export var speed: float
@export var jump_height: float:
	set(value):
		jump_height = value
		jump_velocity = -2.0 * jump_height / jump_time_peak
		jump_gravity = 2.0 * jump_height / jump_time_peak_sqrd
		fall_gravity = 2.0 * jump_height / jump_time_fall_sqrd
@export var jump_time_peak: float:
	set(value):
		jump_time_peak = value
		jump_time_peak_sqrd = value * value
@export var jump_time_fall: float:
	set(value):
		jump_time_fall = value
		jump_time_fall_sqrd = value * value

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: Health = $Health

@onready var jump_time_peak_sqrd: float = jump_time_peak * jump_time_peak
@onready var jump_time_fall_sqrd: float = jump_time_fall * jump_time_fall
@onready var jump_velocity: float = -2.0 * jump_height / jump_time_peak
@onready var jump_gravity: float = 2.0 * jump_height / jump_time_peak_sqrd
@onready var fall_gravity: float = 2.0 * jump_height / jump_time_fall_sqrd
var current_state: PlayerState = PlayerState.DEAD
var max_lives: int
var is_in_water: bool = false

func _ready() -> void:
	max_lives = health.lives

func _input(event: InputEvent) -> void:
	if is_dead():
		return
	if event.is_action_pressed("Switch") and not is_in_water:
		health.die()

func _process(_delta: float) -> void:
	var state: PlayerState = update_state()
	update_animated_sprite(state)

func _physics_process(delta: float) -> void:
	if is_dead():
		return
	velocity.x = InputManager.get_horizontal_input()
	velocity.x *= speed * delta
	velocity.y += get_gravity() * delta
	if can_jump():
		velocity.y = jump_velocity
	move_and_slide()

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func update_state() -> PlayerState:
	if current_state == PlayerState.DEAD:
		return PlayerState.DEAD
	if velocity.length() > 0:
		if is_on_floor():
			return PlayerState.WALK
		if velocity.y < 0:
			return PlayerState.JUMP
		return PlayerState.FALL
	return PlayerState.IDLE

func update_animated_sprite(state: PlayerState, \
	sprite_frames: SpriteFrames = null) -> void:
	if sprite_frames:
		animated_sprite_2d.sprite_frames = sprite_frames
	if state != current_state:
		current_state = state
		match current_state:
			PlayerState.IDLE:
				animated_sprite_2d.play("idle")
			PlayerState.WALK:
				animated_sprite_2d.play("walk")
			PlayerState.JUMP:
				animated_sprite_2d.play("jump")
			PlayerState.FALL:
				animated_sprite_2d.play("fall")
			PlayerState.DEAD:
				animated_sprite_2d.play("death")
	animated_sprite_2d.flip_h = velocity.x < 0

func spawn(character: Constants.Character, new_position: Vector2) -> void:
	position = new_position
	update_animated_sprite(PlayerState.IDLE, sprite_frames[character])
	health.lives = max_lives

func can_jump() -> bool:
	return Input.is_action_pressed("Jump") and is_on_floor() and not is_pushed()

func is_dead() -> bool:
	return current_state == PlayerState.DEAD

func is_pushed() -> bool:
	return current_state == PlayerState.PUSHED

func _on_died() -> void:
	update_animated_sprite(PlayerState.DEAD)

func _on_dived() -> void:
	is_in_water = true

func _on_surfaced() -> void:
	is_in_water = false

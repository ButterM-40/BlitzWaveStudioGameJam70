extends Node2D
class_name StateMachine

@export var animated_sprite_2D: AnimatedSprite2D
@export var starting_state: State

@onready var debug_label: Label = $DebugLabel
var current_state: State

func _ready() -> void:
	for state in get_children():
		if state is State:
			state.animated_sprite_2D = animated_sprite_2D
	switch_state(starting_state)

func _physics_process(delta: float) -> void:
	current_state.process(delta)

func switch_state(new_state: State) -> void:
	if current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	show_state()

func show_state() -> void:
	var text: String = current_state.name
	var offset: float = debug_label.get_rect().size.x / 2
	debug_label.text = text
	debug_label.position.x = -offset

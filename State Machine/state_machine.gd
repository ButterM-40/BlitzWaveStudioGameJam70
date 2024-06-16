extends Node
class_name StateMachine

@export var starting_state: State

@onready var label: Label = $Label
var current_state: State

func _ready() -> void:
	starting_state.enter()
	current_state = starting_state
	label.text = current_state.name

func _physics_process(delta: float) -> void:
	current_state.process(delta)

func switch_state(new_state: State) -> void:
	current_state.exit()
	current_state = new_state
	label.text = current_state.name
	current_state.enter()

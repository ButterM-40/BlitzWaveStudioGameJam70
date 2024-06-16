@tool
extends State
class_name AttackState

signal switch_state(state: State)

@export var not_in_range_state_to_switch: State
@export_category("Settings")
@export var range: int:
	set(value):
		range = value
		if attack_range:
			attack_range.shape.radius = range
@export var cooldown: float:
	set(value):
		cooldown = value
		if attack_cooldown:
			attack_cooldown.wait_time = cooldown

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var attack_range: CollisionShape2D = $AttackRange
var target: Node2D = null

func enter() -> void:
	attack()
	attack_cooldown.start()

func exit() -> void:
	attack_cooldown.stop()

func attack() -> void:
	# attack logic
	print("Attack!")
	pass

func _on_body_entered(body: Node2D) -> void:
	if Engine.is_editor_hint(): # Prevents unwanted behavior when in the editor
		return
	print("Hey")
	target = body
	switch_state.emit(self)

func _on_body_exited(_body: Node2D) -> void:
	if Engine.is_editor_hint():
		return
	switch_state.emit(not_in_range_state_to_switch)

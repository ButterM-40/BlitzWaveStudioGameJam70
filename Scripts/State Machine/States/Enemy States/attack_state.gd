extends State
class_name AttackState

signal switch_state(state: State)

@export var not_in_range_state_to_switch: State

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var attack_range: CollisionShape2D = $AttackRange
var target: Node2D = null

func enter() -> void:
	attack()

func attack() -> void:
	# attack logic
	attack_cooldown.start()

func _on_body_entered(body: Node2D) -> void:
	target = body
	switch_state.emit(self)

func _on_body_exited(_body: Node2D) -> void:
	switch_state.emit(not_in_range_state_to_switch)

extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_meta("TotemType") != "Frog":
		get_node("FrogAbilityCollider").queue_free()

	if get_meta("TotemType") == "Owl":
		gravity_scale = 0

	if get_meta("TotemType") == "Owl":
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, false)
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, false)
	else:
		get_node("OwlCollider").queue_free()

	pass # Replace with function body.

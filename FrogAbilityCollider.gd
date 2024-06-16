extends Area2D


func _physics_process(delta):
	for i in get_overlapping_bodies():
		if i.name == "Player":
			i.current_jump_velocity = -2500
		else:
			get_node('../../../---- Player ----/Player').current_jump_velocity = get_node('../../../---- Player ----/Player').JUMP_VELOCITY
	pass

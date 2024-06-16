extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_overlapping_bodies():
		if i.name == "Player":
			# TODO: Make it so that it places a totem pole and sets character to next
			get_node('../../../---- Player ----/Player').position = get_node('../../../---- Player ----/SpawnPoint').position
	pass

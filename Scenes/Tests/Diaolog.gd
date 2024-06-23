extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Enter"):
		# Move as long as the key/button is pressed.
		visible = false

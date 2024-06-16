extends CanvasLayer
@export var scene_array: Array[PackedScene] = []
var totem = preload("res://UI Totem/TestSprite.tscn")

# Called when the node enters the scene tree for the first time.
#Algorithm will only display the top 5 Totems

func _ready():
	if scene_array.size() > 0:
		generate_sprites()

func _process(delta):
	removeCurrentTotem()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func returnCurrentTotem():
	pass
#This Function removed the first current Totem, and replaces it with the next.
#If empty Display Nothing
func removeCurrentTotem():
	if Input.is_action_just_pressed("Switch"):
		print("Pressed")
		delete_all_children()
		if scene_array.size() > 0:
			scene_array.remove_at(0)
		print(scene_array.size())
		if scene_array.size() > 0:
			generate_sprites()
	pass
func generate_sprites():
	if scene_array.size() > 0:
		var currentTotem = scene_array[0].instantiate()
		print(currentTotem.get_child(0).visible)
		display_current_totem(currentTotem)
		for i in range(scene_array.size()-1):
			i = i + 1
			var sprite = scene_array[i].instantiate()
			print(sprite.get_child(0))
			display_stored_totem(sprite, i, scene_array.size()-1)

func display_current_totem(c):
	c.get_child(0).visible = true
	c.get_child(1).visible = false
	c.position = Vector2((42 * 0)+100, 91)
	c.scale = c.scale * 2
	add_child(c)
	pass
func display_stored_totem(sprite, current_i, max_size):
	sprite.get_child(0).visible = false
	#Child 0 is Selected
	#Child 1 is TotemColor
	var totemDisplayType = sprite.get_child(1)
	totemDisplayType.visible
	if current_i == 1 && current_i != max_size:
		totemDisplayType.get_child(2).visible = true
	elif current_i == max_size:
		if max_size == 1:
			totemDisplayType.get_child(3).visible = true
		else:
			totemDisplayType.get_child(0).visible = true
	else:
		totemDisplayType.get_child(1).visible = true
		
	sprite.position = Vector2((76 * current_i)+200, 91)
	sprite.scale = sprite.scale * 2
	add_child(sprite)
	pass
	
func delete_all_children():
	# Get an array of all child nodes
	var children = get_children()

	# Iterate through the array and queue each child for deletion
	for child in children:
		child.queue_free()

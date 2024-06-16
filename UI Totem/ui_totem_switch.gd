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
	for i in range(scene_array.size()):
		var sprite = totem.instantiate()
		sprite.position = Vector2((100 * i)+100, 91)
		print(sprite.position)
		add_child(sprite)
func delete_all_children():
	
	# Get an array of all child nodes
	var children = get_children()

	# Iterate through the array and queue each child for deletion
	for child in children:
		child.queue_free()

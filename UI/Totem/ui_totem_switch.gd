extends CanvasLayer
@export var scene_array: Array[PackedScene] = []
@export var totem_array: Array[PackedScene] = []
@export var animation_array: Array[SpriteFrames] = []

var totem = preload ("res://Scenes/Tests/TestSprite.tscn")
# Called when the node enters the scene tree for the first time.
#Algorithm will only display the top 5 Totems

func _ready():
	if scene_array.size() > 0:
		generate_sprites()

func _process(_delta):
	removeCurrentTotem()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func returnCurrentTotem():
	pass
#This Function removed the first current Totem, and replaces it with the next.
#If empty Display Nothing
func removeCurrentTotem():
	if Input.is_action_just_pressed("Switch") and scene_array.size() > 0:
		# respawn player
		var player = get_node('../---- Player ----/Player')
		var parent = get_node('../---- Player ----/')

		var totem
		match player.character:
			player.Character.BIDZIIL:
				totem = totem_array[0].instantiate()
			player.Character.GAAGII:
				totem = totem_array[1].instantiate()
			player.Character.AHULI:
				totem = totem_array[2].instantiate()
			player.Character.TATONGA:
				totem = totem_array[3].instantiate()

		var playerFrame = player.player_sprite.get_sprite_frames()
		if scene_array.size() > 1:
			if scene_array[1].instantiate().name == 'BearUi':
				player.character = player.Character.BIDZIIL
				playerFrame = animation_array[0]
			elif scene_array[1].instantiate().name == 'FrogUi':
				player.character = player.Character.GAAGII
				playerFrame = animation_array[2]
			elif scene_array[1].instantiate().name == 'EagleUi':
				playerFrame = animation_array[1]
				player.character = player.Character.AHULI
			elif scene_array[1].instantiate().name == 'TurtleUi':
				player.character = player.Character.TATONGA
				playerFrame = animation_array[3]
		delete_all_children()
		
		#Current Location
		var player_current_positon = player.position
		var player_spawn_point = player.respawn_point.position
		var player_scale = player.scale
		
		totem.position = player_current_positon + Vector2(0, -200)
		parent.add_child(totem)
		
		scene_update(player, player.respawn_point.position, playerFrame)
	pass
	
func scene_update(player, new_position, new_animation: SpriteFrames):
	if scene_array.size() > 0:
			scene_array.remove_at(0)
			player.position = new_position
			player.player_sprite.set_sprite_frames(new_animation)
			player.player_sprite.play("idle")
			generate_sprites()
	if scene_array.size() == 1:
		player.position = new_position
		#player.player_sprite.set_sprite_frames(new_animation)
		player.player_sprite.play("idle")
		
func generate_sprites():
	if scene_array.size() > 0:
		var currentTotem = scene_array[0].instantiate()
		print(currentTotem.get_child(0).visible)
		display_current_totem(currentTotem)
		for i in range(scene_array.size() - 1):
			i = i + 1
			var sprite = scene_array[i].instantiate()
			print(sprite.get_child(0))
			display_stored_totem(sprite, i, scene_array.size() - 1)

func display_current_totem(c):
	c.get_child(0).visible = true
	c.get_child(1).visible = false
	c.position = Vector2((42 * 0) + 100, 91)
	c.scale = c.scale * 2
	add_child(c)
	pass
func display_stored_totem(sprite, current_i, max_size):
	sprite.get_child(0).visible = false
	#Child 0 is Selected
	#Child 1 is TotemColor
	var totemDisplayType = sprite.get_child(1)
	#totemDisplayType.visible
	if current_i == 1&&current_i != max_size:
		totemDisplayType.get_child(2).visible = true
	elif current_i == max_size:
		if max_size == 1:
			totemDisplayType.get_child(3).visible = true
		else:
			totemDisplayType.get_child(0).visible = true
	else:
		totemDisplayType.get_child(1).visible = true
		
	sprite.position = Vector2((76 * current_i) + 200, 91)
	sprite.scale = sprite.scale * 2
	add_child(sprite)
	pass
	
func delete_all_children():
	# Get an array of all child nodes
	var children = get_children()

	# Iterate through the array and queue each child for deletion
	for child in children:
		child.queue_free()

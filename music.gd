extends Node2D


var music_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var music_player = get_node('Music')
	
	if music_playing && !music_player.playing:
		music_player.playing = true
	elif !music_playing:
		music_player.playing = false
	pass

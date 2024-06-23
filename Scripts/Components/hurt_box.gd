extends Area2D
class_name HurtBox

@export var hurt_sounds: Array[AudioStreamWAV]

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.respawn()
	
	for child in body.get_children():
		if child is Health:
			child.take_damage()
			break
	
	audio_stream_player_2d.stream = hurt_sounds.pick_random()
	audio_stream_player_2d.play()

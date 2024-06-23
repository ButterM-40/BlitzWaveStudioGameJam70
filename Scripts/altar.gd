extends Activator
class_name Altar

@export var required_totem: Constants.TotemType

@onready var light_sprite: AnimatedSprite2D = $LightSprite

func _ready() -> void:
	light_sprite.frame = required_totem

func _on_body_entered(body: Node2D) -> void:
	print('entered:', body)
	if body.type == required_totem:
		activate()

extends TextureRect
class_name MainPortraitDisplay

@export var character_textures: Array[CompressedTexture2D]
var default_texture: CompressedTexture2D

func _ready() -> void:
	default_texture = texture

func update(character: Constants.Character) -> void:
	texture = character_textures[character]

func clear() -> void:
	texture = default_texture

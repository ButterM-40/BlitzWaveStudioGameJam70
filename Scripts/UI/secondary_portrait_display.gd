extends TextureRect
class_name SecondaryPortraitDisplay

enum Arrangement {
	SOLO,
	FIRST,
	MIDDLE,
	LAST
}

@export var dot_textures: Array[CompressedTexture2D]
@export var portrait_textures: Array[CompressedTexture2D]

@onready var dot_display: TextureRect = $DotDisplay
var arrangement: Arrangement = Arrangement.MIDDLE

func set_portrait(new_arrangement: Arrangement) -> void:
	arrangement = new_arrangement
	texture = portrait_textures[arrangement]

func set_content(character: Constants.Character) -> void:
	dot_display.texture = dot_textures[character]

func update(character: Constants.Character, new_arrangement: Arrangement = -1) -> void:
	dot_display.texture = dot_textures[character]
	if new_arrangement != -1:
		arrangement = new_arrangement
		texture = portrait_textures[arrangement]

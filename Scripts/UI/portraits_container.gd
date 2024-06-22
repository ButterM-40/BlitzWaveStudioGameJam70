extends HBoxContainer
class_name PortaitsContainer

const SECONDARY_PORTRAIT_DISPLAY = preload("res://Scenes/UI/secondary_portrait_display.tscn")

@onready var main_portrait: MainPortraitDisplay = $MainPortraitDisplay
@onready var secondary_portraits: HBoxContainer = $SecondaryPortraitsContainer

func create_secondary_portraits(amount: int) -> void:
	clear_secondary_portraits()
	if amount <= 0:
		return
	var secondary_portraits_count: int = amount - 1
	for i in range(secondary_portraits_count):
		secondary_portraits.add_child( \
			SECONDARY_PORTRAIT_DISPLAY.instantiate())
	if amount > 1:
		secondary_portraits.get_child(0) \
			.set_portrait(SecondaryPortraitDisplay.Arrangement.FIRST)
		secondary_portraits.get_child(-1) \
			.set_portrait(SecondaryPortraitDisplay.Arrangement.LAST)
		for i in range(1, secondary_portraits_count):
			secondary_portraits.get_child(i) \
				.set_portrait(SecondaryPortraitDisplay.Arrangement.MIDDLE)
	else:
		secondary_portraits.get_child(0) \
			.set_portrait(SecondaryPortraitDisplay.Arrangement.SOLO)

func clear_secondary_portraits() -> void:
	for node in secondary_portraits.get_children():
		node.queue_free()

func update(characters: Array[Constants.Character], index: int) -> void:
	main_portrait.update(characters[index])
	update_secondary(characters, index + 1)

func update_secondary(characters: Array[Constants.Character], index: int) -> void:
	var remaining: int = characters.size() - index
	if remaining == 1:
		update_solo(characters[index])
	elif remaining > 1:
		update_multiple(characters, index, remaining)
	hide_unused_portrait(remaining)

func update_solo(character: Constants.Character, \
	arrangement := SecondaryPortraitDisplay.Arrangement.SOLO, i: int = 0) -> void:
	var portrait: SecondaryPortraitDisplay = secondary_portraits.get_child(i)
	portrait.update(character, arrangement)
	portrait.show()

func update_multiple(characters: Array[Constants.Character], index: int, remaining: int) -> void:
	update_solo(characters[index], SecondaryPortraitDisplay.Arrangement.FIRST)
	var last_index: int = remaining - 1
	update_solo(characters[-1], SecondaryPortraitDisplay.Arrangement.LAST, last_index)
	while last_index > 1:
		last_index -= 1
		var character: Constants.Character = characters[index + last_index]
		var arrangement := SecondaryPortraitDisplay.Arrangement.MIDDLE
		update_solo(character, arrangement, last_index)

func hide_unused_portrait(remaining: int) -> void:
	for i in range(remaining, secondary_portraits.get_child_count()):
		secondary_portraits.get_child(i).hide()

extends CanvasLayer

@onready var label = $TextLabelInsideBox

func type(text):
	label.visible_ratio = 0
	label.text = text
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, 1)
	

@tool
class_name PartInfo extends Resource

@export var name: String = "":
	get:
		return name
	set(new_name):
		name = new_name
		emit_changed()

@export var image: Texture = null:
	get:
		return image
	set(new_image):
		image = new_image
		emit_changed()

@export var modifiers: Array[PropertyModifier] = []:
	get:
		return modifiers
	set(new_modifiers):
		modifiers = new_modifiers
		emit_changed()

func _init(
	p_name: String = "",
	image: Texture = null,
	p_modifiers: Array[PropertyModifier] = []
):
	name = p_name
	modifiers = p_modifiers

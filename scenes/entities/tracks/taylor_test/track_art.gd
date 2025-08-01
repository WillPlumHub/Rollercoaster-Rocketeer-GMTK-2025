@tool
class_name TrackArt extends Control

@onready var beam_art_mask: Panel = %BeamArtMask
@onready var beam_art: Panel = %BeamArt

@export var style_box_mask: StyleBox = null:
	get:
		return style_box_mask
	set(new_style_box_mask):
		style_box_mask = new_style_box_mask
		_update_style_box_mask()

func _update_style_box_mask():
	if beam_art_mask == null or style_box_mask == null:
		return
	beam_art_mask.add_theme_stylebox_override("panel", style_box_mask)

func _ready() -> void:
	_update_style_box_mask()
	_on_resized()

func _on_resized() -> void:
	_update_mask_size()
	_update_beam_art_size()

func _update_mask_size() -> void:
	var x_remainder: float = fmod(size.x, 32)
	var new_x = size.x - x_remainder
	beam_art_mask.size = Vector2(new_x, size.y)
	beam_art_mask.position = Vector2.ZERO

func _update_beam_art_size() -> void:
	var scaled_size = size * 2
	var x_remainder: float = fmod(scaled_size.x, 64)
	var y_remainder: float = fmod(scaled_size.y, 128)
	var new_x = scaled_size.x - x_remainder
	var new_y_art_offset = -128 + y_remainder
	var new_y = scaled_size.y + 128 - y_remainder
	beam_art.size = Vector2(new_x, new_y)
	beam_art.position = Vector2(0, new_y_art_offset / 2)

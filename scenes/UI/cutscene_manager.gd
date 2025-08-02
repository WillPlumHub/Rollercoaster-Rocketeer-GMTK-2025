extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect: TextureRect = $TextureRect

@export var cut_scene:CutsceneFrames

func _on_next_slide_pressed() -> void:
	var next_frame = cut_scene.get_next_frame()
	if next_frame == null:
		animation_player.play("fade")
	else:
		texture_rect.texture = next_frame

extends Button

func _ready() -> void:
	pivot_offset.x = size.x/2
	pivot_offset.y = size.y/2

func _on_mouse_entered() -> void:
	SoundManager.play_sound('button_hover', 1, 0)
	var t = create_tween().set_trans(Tween.TRANS_CIRC)
	t.tween_property(self, "scale", Vector2(1.2, 1), 0.2)

func _on_mouse_exited() -> void:
	var t = create_tween().set_trans(Tween.TRANS_CIRC)
	t.tween_property(self, "scale", Vector2(1, 1), 0.2)

func _on_pressed() -> void:
	SoundManager.play_sound('button_press', 1, 0)

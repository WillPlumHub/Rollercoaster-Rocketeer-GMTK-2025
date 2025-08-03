@tool
extends Parallax2D

func _ready() -> void:
	for i in range(100):
		var new_tree = Sprite2D.new()
		new_tree.texture = [load("res://assets/art/oak1.webp"), load("res://assets/art/oak2.webp")].pick_random()
		new_tree.position = Vector2(i*randi_range(120, 150), randi_range(-20, 20))
		new_tree.flip_h = [false, true].pick_random()
		add_child(new_tree)

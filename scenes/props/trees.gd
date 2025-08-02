extends Parallax2D

func _ready() -> void:
	for i in range(100):
		var new_tree = Sprite2D.new()
		new_tree.texture = load("res://assets/art/Asteroids.png")
		new_tree.position = Vector2(i*50, randi_range(-20, 20))
		add_child(new_tree)

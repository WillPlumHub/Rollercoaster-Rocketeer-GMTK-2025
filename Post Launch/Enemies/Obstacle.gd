extends Area2D

var level_progress: LevelProgress
var rotationSpeed = 1
var ship: Node2D


func _ready():
	# Get LevelProgress (direct parent)
	level_progress = get_parent() as LevelProgress
	# Get Ship (sibling of LevelProgress, grandparent of this node)
	var root = get_parent().get_parent()
	ship = root.get_node("Ship")  # Make sure node name is exactly "Ship"
	# Randomly determine rotation
	var direction := 1
	if randf() < 0.5:
		direction = -1
	var speed := deg_to_rad(90)  # 90 degrees per second
	rotationSpeed = direction * speed


func _process(delta):
	rotation += rotationSpeed * delta


func _on_area_entered(area: Area2D) -> void:
	if (area.collision_layer & (1 << 0)):  # Layer 1 = player's body
		if (ship.armor > 0):
			ship.armor -= 1
		else:
			level_progress.speed -= 50
			print("Speed: ", level_progress.speed)
	queue_free()

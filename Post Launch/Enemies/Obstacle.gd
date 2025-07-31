extends Area2D

var level_progress: LevelProgress
var rotation_speed = 1.0
var ship: Node2D


func _ready():
	# Navigate to root
	var root = get_tree().get_current_scene()
	# Get LevelProgress safely
	var lp_node = root.get_node_or_null("LevelProgress")
	if lp_node and lp_node is LevelProgress:
		level_progress = lp_node
	else:
		push_error("LevelProgress not found!")
		return
		
	# Get Ship safely
	ship = root.get_node_or_null("Ship") as Ship
	if not ship:
		push_error("Ship not found or not of type 'Ship'!")

	# Random rotation direction and speed
	var direction := 1
	if randf() < 0.5:
		direction = -1
	var speed := deg_to_rad(90)
	rotation_speed = direction * speed


func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area and (area.collision_layer & (1 << 0)):
		if ship and ship.armor > 0:
			ship.armor -= 1
		else:
			if level_progress:
				level_progress.speed -= 50
				print("Speed:", level_progress.speed)
	queue_free()

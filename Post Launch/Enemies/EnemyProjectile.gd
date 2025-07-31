extends Area2D
class_name EnemyBullet

var speed = 500  # pixels per second
var level_progress: LevelProgress


func _ready():
	# Traverse upward to find the LevelProgress node
	var current = get_parent()
	while current != null:
		if current is LevelProgress:
			level_progress = current
			break
		current = current.get_parent()
	if level_progress == null:
		push_warning("EnemyBullet could not find LevelProgress in the scene tree.")


func _process(delta):
	position.y += speed * delta
	# Off-screen cleanup
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer & (1 << 0):  # Layer 1 = player's body
		if level_progress:
			level_progress.passengers -= 5 # Decrease passenger amount
			if (level_progress.speed > 0):
				level_progress.speed -= 50  # Decrease player speed
			print("Speed: ", level_progress.speed, " Passengers: ", level_progress.passengers)
		queue_free()

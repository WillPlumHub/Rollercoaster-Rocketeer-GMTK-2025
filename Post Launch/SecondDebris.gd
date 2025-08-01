extends Node2D

class_name SecondDebris

var speed: float = 180
var level_progress: LevelProgress

func _ready():
	# Go up one level and look for sibling node named "LevelProgress"
	var parent = get_parent()
	if parent:
		var lp_node = parent.get_node_or_null("../LevelProgress")
		if lp_node and lp_node is LevelProgress:
			level_progress = lp_node
		else:
			print("LevelProgress not found or is wrong type")
	else:
		print("Parent node missing")

func _process(delta: float) -> void:
	position.y += speed * delta

	if speed >= 0 and level_progress:
		speed -= level_progress.deceleration * delta

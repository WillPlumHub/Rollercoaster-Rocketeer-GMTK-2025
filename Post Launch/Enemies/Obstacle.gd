extends Area2D

var level_progress: LevelProgress

func _ready():
	level_progress = get_parent() as LevelProgress

func _on_area_entered(area: Area2D) -> void:
		print("Asteroid hit by projectile!")
		level_progress.speed -= 50
		queue_free()

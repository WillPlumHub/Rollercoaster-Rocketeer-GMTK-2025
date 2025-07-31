extends Area2D

class_name BasicEnemy

var shooting = false
var level_progress: LevelProgress
var projectileOffset := 0
var shot_cooldown := 2.0
var time_since_last_shot := 0.0

const BULLET_SCENE: PackedScene = preload("res://Post Launch/Enemies/enemy_projectile.tscn")


func _ready():
	level_progress = get_parent() as LevelProgress


func _process(delta):
	time_since_last_shot += delta
	
	if level_progress and level_progress.speed < 0:
		shooting = false
	else:
		shooting = get_viewport_rect().has_point(global_position)
	
	if shooting and time_since_last_shot >= shot_cooldown:
		shoot()
		time_since_last_shot = 0.0
	
	if global_position.y > get_viewport_rect().size.y + 50:
		queue_free()


func shoot():
	if BULLET_SCENE:
		var shot = BULLET_SCENE.instantiate()
		shot.global_position = global_position + Vector2(0, projectileOffset)
		get_tree().current_scene.add_child(shot)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):  # Add your projectile to the "projectile" group
		print("Enemy hit by projectile!")
		level_progress.money += 10
		level_progress.speed -= 50
		# Increase customer money
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

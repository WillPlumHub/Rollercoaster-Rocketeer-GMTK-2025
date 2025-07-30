extends Sprite2D
class_name BasicEnemy

# Projectile prefab
const BULLET_SCENE: PackedScene = preload("res://enemy_projectile.tscn")

# Shooting logic
var shooting = false
var projectileOffset := 0
var shot_cooldown := 2.0  # seconds
var time_since_last_shot := 0.0

func _process(delta):
	time_since_last_shot += delta
	
	var screen_rect = get_viewport_rect()
	if screen_rect.has_point(global_position):
		shooting = true
	else:
		shooting = false
	
	if (shooting && time_since_last_shot >= shot_cooldown):
		shoot()
		time_since_last_shot = 0.0
	
	if (global_position.y > screen_rect.size.y + 50):
		queue_free()

func shoot():
	if BULLET_SCENE:
		var shot = BULLET_SCENE.instantiate()
		shot.global_position = global_position + Vector2(0, projectileOffset)
		get_tree().current_scene.add_child(shot)
	else:
		print("Projectile not assigned!")

# This gets called when another physics body (player, projectile) enters the Area2D
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "projectile" or body.is_in_group("projectile"):
		print("Hit by a projectile!")
		queue_free()
	else:
		print("Collided with:", body.name)

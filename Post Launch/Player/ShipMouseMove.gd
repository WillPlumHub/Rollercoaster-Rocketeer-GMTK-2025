extends Sprite2D

class_name Ship

const BULLET_SCENE: PackedScene = preload("res://Post Launch/Player/projectile.tscn")

# Movement
var yPosition = 550
var Speed = 100

# Shooting
var shooting = true
var projectileOffset = 0
var shot_cooldown = 2.0  # Seconds
var time_since_last_shot = 0.0

func _process(delta):
	var global_mouse_pos = get_global_mouse_position()
	var direction = (global_mouse_pos - global_position).normalized()
	
	global_position.x = global_mouse_pos.x
	global_position.y = yPosition
	
	if (global_position.x >= 1050):
		global_position.x = 1050
	if (global_position.x <= 100):
		global_position.x = 100
	
	time_since_last_shot += delta
	
	if (shooting == true && time_since_last_shot >= shot_cooldown):
		shoot()
		time_since_last_shot = 0.0

func shoot():
	if BULLET_SCENE:
		var shot = BULLET_SCENE.instantiate()
		shot.global_position = Vector2(global_position.x, global_position.y + projectileOffset)
		get_tree().current_scene.add_child(shot)
	else:
		print("Projectile not assigned!")

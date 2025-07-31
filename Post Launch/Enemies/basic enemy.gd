extends Area2D

class_name BasicEnemy

var shooting = false
var level_progress: LevelProgress
var projectileOffset := 10
var shot_cooldown := 0.5
var time_since_last_shot := 0.0
var ship: Node2D

const BULLET_SCENE: PackedScene = preload("res://Post Launch/Enemies/enemy_projectile.tscn")


func _ready():
	level_progress = get_parent() as LevelProgress
	
	# Get Ship (sibling of LevelProgress, grandparent of this node)
	var root = get_parent().get_parent()
	ship = root.get_node("Ship")  # Make sure node name is exactly "Ship"


func _process(delta):
	time_since_last_shot += delta
	
	if level_progress and level_progress.speed < 0:
		shooting = false
	else:
		shooting = get_viewport_rect().has_point(global_position)
	
	if (shooting and time_since_last_shot >= shot_cooldown):
		shoot()
		time_since_last_shot = 0.0
	
	if global_position.y > get_viewport_rect().size.y + 50:
		queue_free()


func shoot():
	if BULLET_SCENE:
		var shot = BULLET_SCENE.instantiate()
		shot.global_position = global_position + Vector2(0, projectileOffset)
		shot.position = Vector2(0, projectileOffset)  # local to enemy
		add_child(shot)



func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer & (1 << 0): # Layer 1 = player's body
		if (ship.armor > 0):
			ship.armor -= 1
		else:
			level_progress.speed -= 50 # Decrease player speed
			print("Speed: ", level_progress.speed)
	elif (area.collision_layer & (1 << 2)): # Layer 3 = player's projectile
		level_progress.money += (1 * level_progress.passengers) # Increase customer cash
		print("Money: ", level_progress.money)
	print("Enemy hit by projectile!")
	queue_free()

extends Sprite2D

class_name Bullet

var speed = 500  # pixels per second

func _ready():
	add_to_group("projectile")

func _process(delta):
	position.y -= speed * delta
	
	if (global_position.y < -80):
		queue_free()

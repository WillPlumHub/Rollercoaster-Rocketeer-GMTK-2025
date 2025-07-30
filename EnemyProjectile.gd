extends Sprite2D

class_name EnemyBullet

var speed = 500  # pixels per second

func _process(delta):
	position.y += speed * delta
	
	if (position.y > get_viewport_rect().size.y + 100):
		queue_free()

extends Area2D

class_name Bullet

var speed = 500  # pixels per second
var brickThru = true


func _ready():
	add_to_group("projectile")


func _process(delta):
	position.y -= speed * delta
	
	if (global_position.y < -80):
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if (area.collision_layer & (1 << 1) && brickThru): # Layer 2 = hazzards
		queue_free()

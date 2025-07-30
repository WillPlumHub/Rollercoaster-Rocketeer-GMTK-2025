extends Node2D

class_name LevelProgress

var speed = 200
var decceleration = 20

var distance = 0
var targetHeight = 150


func _process(delta):
	position.y += speed * delta
	
	if (speed >= 0):
		speed -= (decceleration * delta)
		distance += (decceleration * delta)
	
	# If player fails run
	if (speed < 0 && distance < targetHeight):
		print("GAME OVER")
	
	# If player succeeds run
	if (distance >= targetHeight):
		print("WIN!")
	
	print("distance: ", distance)

extends Node2D

class_name LevelProgress

var speed = 200
var decceleration = 20

var distance = 0
var targetHeight = 150

var money = 0
var passengers = 10


func _process(delta):
	position.y += speed * delta
	if (speed >= 0):
		speed -= (decceleration * delta)
		distance += (decceleration * delta)
	# If player fails run
	if (speed < 0 && distance < targetHeight):
		print("GAME OVER")
		# Load finish scene
	# If player succeeds run
	if (distance >= targetHeight):
		print("WIN!")
		# Load success scene
	#print("distance: ", distance)
	#print("speed: ", speed)

extends PathFollow2D
class_name Car

var track_attached:TrackPart
var speed:float = -1
var end_of_track:bool = false

func _ready() -> void:
	if speed == -1:
		speed = track_attached.track_speed

func _process(delta: float) -> void:
	progress_ratio += 0.2 * delta * speed
	
	if rotation_degrees > 10 and !end_of_track:
		speed += 0.1 * delta
		speed *= 1.01
		
	if rotation_degrees < -10 and !end_of_track:
		speed -= 0.07 * delta
		speed *= 0.99
	
	if progress_ratio >= 0.99:
		if track_attached.track_right:
			track_attached.pass_on_train_car(speed)
			queue_free()
		else:
			speed = 0
			end_of_track = true

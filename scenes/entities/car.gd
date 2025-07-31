extends PathFollow2D
class_name Car

var track_attached:TrackPart
var speed:float = -1
var end_of_track:bool = false

func _ready() -> void:
	if speed == -1:
		# IF SPEED IS -1 THEN IT IS A NEW CAR AND DOESNT CARE ABOUT KEEPING MOMENTUM
		speed = track_attached.track_speed

func _process(delta: float) -> void:
	# MOVE ALONG TRACK
	if !end_of_track:
		progress_ratio += 0.2 * delta * speed
	
	if rotation_degrees > 10 and !end_of_track:
		# IF FACING DOWN, ACCELERATE
		speed += 0.1 * delta
		speed *= 1.01
		
	if rotation_degrees < -10 and !end_of_track:
		# IF FACING UP SLOW DOWN
		speed -= 0.07 * delta
		speed *= 0.99
	
	if !end_of_track:
		# ClAMP THE SPEED WHILE RIDING THE TRACK
		speed = clamp(speed, 0.3, 3)
	
	if progress_ratio >= 0.99:
		# WHEN FINISHED TRACK, EITHER STOP OR MOVE TO NEXT TRACK
		if track_attached.track_right:
			track_attached.pass_on_train_car(speed)
			queue_free()
		else:
			if end_of_track == false:
				end_of_track = true

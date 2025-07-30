extends PathFollow2D
class_name Car

var track_attached:TrackPart
var speed:float

func _ready() -> void:
	speed = track_attached.track_speed

func _process(delta: float) -> void:
	progress_ratio += 0.2 * delta * speed
	if progress_ratio >= 0.99:
		if track_attached.track_right and track_attached.track_cooldown == false:
			track_attached.pass_on_train_car()
			queue_free()
		else:
			speed = 0

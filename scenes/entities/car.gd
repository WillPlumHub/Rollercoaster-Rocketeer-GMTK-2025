extends PathFollow2D
class_name Car

@export_flags_2d_physics var collision_layer: int = 1
@export_flags_2d_physics var collision_mask: int = 1
@export var rigid_body: RigidBody2D

var track_attached:TrackPart
var speed:float = -1
var end_of_track:bool = false


func _ready() -> void:
	if speed == -1:
		# IF SPEED IS -1 THEN IT IS A NEW CAR AND DOESNT CARE ABOUT KEEPING MOMENTUM
		speed = track_attached.track_speed


func _process(delta: float) -> void:
	# MOVE ALONG TRACK
	var next = false;
	var offset = 2.0 * delta * speed
	if !end_of_track:
		var f = progress
		progress += offset
		if f > progress:
			progress_ratio = .999
			next = true
	else:
		position += Vector2(cos(rotation), sin(rotation)) * offset
	
	if rotation_degrees > 10 and !end_of_track:
		# IF FACING DOWN, ACCELERATE
		speed += 1.0 * delta
		speed *= 1.01
	elif rotation_degrees < -10 and !end_of_track:
		# IF FACING UP SLOW DOWN
		speed -= .70 * delta
		speed *= 0.99
	elif speed > track_attached.track_speed:
		speed = lerp(speed, track_attached.track_speed, 0.01)
	
	if !end_of_track:
		# ClAMP THE SPEED WHILE RIDING THE TRACK
		speed = max(speed, 3.0)
	
	if next:
		# WHEN FINISHED TRACK, EITHER STOP OR MOVE TO NEXT TRACK
		if track_attached.track_right && !track_attached.is_ending_track:
			track_attached.pass_on_train_car(self, speed)
			# queue_free()
		else:
			rigid_body.reparent(get_tree().current_scene)
			rigid_body.sleeping = false
			rigid_body.freeze = false
			rigid_body.linear_velocity =  Vector2(cos(rotation), sin(rotation)) * speed * 2.0
			rigid_body.collision_layer = collision_layer
			rigid_body.collision_mask = collision_mask
			queue_free()

extends Node2D
class_name TrackPart

# EXPORTED VARs
@export var track_right:NodePath
@export var is_starting_track:bool = false

# GETTING NODES
@onready var path_follow_2d: PathFollow2D = $coaster_path/PathFollow2D
@onready var coaster_path: Path2D = $coaster_path

# SCRIPT VARs
var track_speed:float = 1
var car_count:int = 5
var grabbed:bool = false
var grab_offset:Vector2 = Vector2.ZERO
var track_cooldown:bool = false

func _ready() -> void:
	if is_starting_track:
		# IF THIS TRACK IS THE FIRST ONE, SPAWN A CAR
		for i in range(car_count):
			grab_train_car(new_car())
			# SLIGHT DELAY BETWEEN CARs
			await get_tree().create_timer(0.5).timeout

func _process(_delta: float) -> void:
	if grabbed:
		position = get_global_mouse_position() + grab_offset

# RETURNS A NEW TRAIN CAR SCENE
func new_car():
	return load("res://scenes/entities/car.tscn").instantiate()

# FOR A TRACK PEICE TO GRAB A TRAIN CAR
func grab_train_car(train_car):
	train_car.track_attached = self
	coaster_path.add_child(train_car)

# ALLOWS THIS SCENE TO PASS A NEW CAR TO THE NEXT TRACK
func pass_on_train_car():
	if track_right:
		get_node(track_right).grab_train_car(new_car())

func _on_track_end_area_entered(area: Area2D) -> void:
	# GETS THE TRACK THAT IS IN PROXIMITY FROM AREA 2D
	track_right = area.get_parent().get_path()

func _on_track_end_area_exited(area: Area2D) -> void:
	# IF THE TRACK CONNECTED MOVES AWAY, DISCONNECT IT
	track_right = ""

func _on_grab_detect_button_down() -> void:
	# WHEN MOUSE DOWN SET GRABBED TO TRUE AND GET OFFSET
	grab_offset = position - get_global_mouse_position()
	grabbed = true

func _on_grab_detect_button_up() -> void:
	# WHEN MOUSE RELASED SET GRABBED TO FALSE
	grabbed = false

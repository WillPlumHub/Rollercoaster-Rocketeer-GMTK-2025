extends Camera2D

@export var zoom_step := 0.1
@export var zoom_min := 0.5
@export var zoom_max := 2.0
@export var pan_speed := 200.0
@export var min_y_position := -1.0  # Lower limit for vertical pan
@export var max_y_position := 300.0  # Upper limit for vertical pan

@export var launch := false  # If true, follow rollercoaster instead of player
@export var player_node: Node2D
var rollercoaster_node: Node2D = null

var zoom_level := 0.7

func set_rollercoaster(coaster: Node2D) -> void:
	rollercoaster_node = coaster

func _ready() -> void:
	zoom = Vector2(zoom_level, zoom_level)
	player_node = get_node("../Player")
	rollercoaster_node = get_node("../Player")
	GameData.launch_train_cars.connect(_hide_camera)
	set_deferred("enabled", true)

func _hide_camera():
	print("hiding camera....")
	set_deferred("enabled", false)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_level = clamp(zoom_level - zoom_step, zoom_min, zoom_max)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_level = clamp(zoom_level + zoom_step, zoom_min, zoom_max)
		zoom = Vector2(zoom_level, zoom_level)

func _process(delta: float) -> void:
	var target: Node2D = null
	#print("launch = ", launch)
	#if launch:
		#target = rollercoaster_node
	#else:
	target = player_node

	if target:
		global_position.x = target.global_position.x
		global_position.y = target.global_position.y

	# Allow vertical panning input
	var pan_direction := 0
	if Input.is_action_pressed("prelaunch_up"):
		pan_direction -= 1
	if Input.is_action_pressed("prelaunch_down"):
		pan_direction += 1

	if pan_direction != 0:
		global_position.y += pan_direction * pan_speed * delta

	# Clamp vertical position
	global_position.y = clamp(global_position.y, min_y_position, max_y_position)

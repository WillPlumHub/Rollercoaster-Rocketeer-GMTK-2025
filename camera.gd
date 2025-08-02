extends Camera2D

@export var zoom_step := 0.1
@export var zoom_min := 0.5
@export var zoom_max := 2.0
@export var pan_speed := 200.0
@export var min_y_position := -1.0  # Lower limit for vertical pan

var zoom_level := 1.0

func _ready() -> void:
	zoom = Vector2(zoom_level, zoom_level)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_level = clamp(zoom_level - zoom_step, zoom_min, zoom_max)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_level = clamp(zoom_level + zoom_step, zoom_min, zoom_max)
		zoom = Vector2(zoom_level, zoom_level)

func _process(delta: float) -> void:
	var pan_direction := 0
	if Input.is_action_pressed("prelaunch_up"):
		pan_direction -= 1
	if Input.is_action_pressed("prelaunch_down"):
		pan_direction += 1
	if pan_direction != 0:
		global_position.y += pan_direction * pan_speed * delta
		#global_position = Vector2(global_position.x, max(global_position.y, min_y_position))
		global_position = Vector2(global_position.x, clamp(global_position.y, -1.0, 500.0))

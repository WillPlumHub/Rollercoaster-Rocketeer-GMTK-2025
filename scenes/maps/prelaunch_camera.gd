extends Camera2D

@export var panning_speed: int

var direction

# Mouse movement set here for more responsiveness.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		direction = event.relative
		position += direction * panning_speed * get_process_delta_time()
		
 
# Keyboard panning input set here, so it scrolls consistently.
func _process(delta: float) -> void:
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	if direction != Vector2.ZERO:
		position += direction * panning_speed * delta
	
	
	

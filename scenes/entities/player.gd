extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_detector: Area2D = $InteractionDetector

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var min_x_position := -200.0
@export var max_x_position := 1500.0

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("prelaunch_interact"):
		var interaction = interaction_detector.get_overlapping_areas()
		if interaction:
			print(interaction[0].building_scene)
		

func _physics_process(delta: float) -> void:

	var direction := Input.get_axis("prelaunch_left", "prelaunch_right")
	
	animated_sprite_2d.speed_scale = abs(direction)
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# Clamp player's X position within bounds
	global_position = Vector2(clamp(global_position.x, min_x_position, max_x_position), global_position.y)


# Unused portion of CharacterBody2D code template 

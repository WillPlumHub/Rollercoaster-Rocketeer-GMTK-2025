extends CharacterBody2D

const SPEED = 10.0
const JUMP_VELOCITY = -900.0

@export var gravity_component: GravityComponent


func _physics_process(delta: float) -> void:
	var acceleration: Vector2 = Vector2.ZERO
	
	# Add the gravity.
	if not is_on_floor():
		acceleration.y = gravity_component.gravity_force * delta
	else:
		acceleration.y = 0.0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		acceleration.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		acceleration.x = direction * SPEED
	else:
		acceleration.x = 0.0
		
	velocity += acceleration.x * gravity_component.right + acceleration.y * gravity_component.up
	rotation = lerp_angle(rotation, atan2(gravity_component.right.y, gravity_component.right.x), 0.1)

	move_and_slide()

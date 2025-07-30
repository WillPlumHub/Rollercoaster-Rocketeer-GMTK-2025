extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -900.0

@export var gravity_component: GravityComponent
var speed: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_wall():
		speed.y += gravity_component.gravity_force * delta
	else:
		speed.y = 0.0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		speed.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		speed.x = direction * SPEED
	else:
		speed.x = move_toward(speed.x, 0.0, SPEED)
		
	velocity = speed.x * gravity_component.right + speed.y * gravity_component.up
	rotation = atan2(gravity_component.right.y, gravity_component.right.x)

	move_and_slide()

extends Node2D
class_name Thrusters

const FORCE = 1000.0

var fuel = 100.0


func _physics_process(delta: float) -> void:
	var body = get_parent()
	if Input.is_action_pressed("launch.activate_thrust") && !is_zero_approx(fuel):
		var wish_dir = (get_global_mouse_position() - global_position).normalized()
		if body is RigidBody2D && !wish_dir.is_zero_approx():
			body.apply_central_force(FORCE * wish_dir)
		fuel -= delta

extends Node2D
class_name Thrusters

const FORCE = 1000.0


func _physics_process(delta: float) -> void:
	var body = get_parent()
	var wish_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if body is RigidBody2D:
		body.apply_central_force(FORCE * wish_dir)

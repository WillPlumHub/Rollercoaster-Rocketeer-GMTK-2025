extends Area2D
class_name GravityField2D


func _on_body_entered(body: Node2D) -> void:
	var gc = GravityComponent.get_gravity_component(body)
	if gc:
		gc.center_point = gravity_point_center
		gc.gravity_force = gravity

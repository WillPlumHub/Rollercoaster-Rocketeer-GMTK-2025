extends Area2D
class_name GravityField2D


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	var gc = GravityComponent.get_gravity_component(body)
	if gc:
		gc.center_point = gravity_point_center
		gc.gravity_force = gravity
		gc.in_gravity_field = true
	

func _on_body_exited(body: Node2D) -> void:
	var gc = GravityComponent.get_gravity_component(body)
	if gc:
		gc.gravity_force = 0.0
		gc.in_gravity_field = false

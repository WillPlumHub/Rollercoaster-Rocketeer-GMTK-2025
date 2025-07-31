extends RigidBody2D


func _ready(): 
	print($HealthComponent.health)


func _on_health_component_killed() -> void:
	queue_free()


func _on_health_component_damaged() -> void:
	print($HealthComponent.health)

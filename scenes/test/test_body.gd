extends RigidBody2D


func _ready(): 
	#print($HealthComponent.health)
	pass


func _on_health_component_killed() -> void:
	print("You died")
	queue_free()


func _on_health_component_damaged() -> void:
	#print($HealthComponent.health)
	pass

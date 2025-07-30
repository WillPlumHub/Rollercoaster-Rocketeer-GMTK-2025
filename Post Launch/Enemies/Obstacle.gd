extends Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):  # Add your projectile to the "projectile" group
		print("Asteroid hit by projectile!")
		queue_free()

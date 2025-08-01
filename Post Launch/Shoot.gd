extends Area2D

func shoot(projectileOffset, BULLET_SCENE):
	if BULLET_SCENE:
		var shot = BULLET_SCENE.instantiate()
		
		# Add to root first to avoid transform issues
		var scene_root = get_tree().get_current_scene()
		scene_root.add_child(shot)
		
		# Set global position with offset
		shot.global_position = global_position + Vector2(0, projectileOffset)
	else:
		print("Projectile not assigned!")

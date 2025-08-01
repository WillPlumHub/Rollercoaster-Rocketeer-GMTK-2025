extends CanvasLayer

func _on_launch_pressed() -> void:
	GameData.launch_train_cars.emit()
	$launch.disabled = true

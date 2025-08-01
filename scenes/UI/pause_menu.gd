extends Control

@onready var pause_menu = $"."
@onready var main_scene = $"/maps/build_scene/"
var paused =false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	


func _on_resume_pressed() -> void:
	#main_scene.pauseMenu()
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()

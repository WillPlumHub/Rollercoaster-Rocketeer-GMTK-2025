extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var info = GameData.player_info.calculate_final_launch_stats()
	info.thruster_power

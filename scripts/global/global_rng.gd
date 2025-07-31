## class_name GlobalRng
extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

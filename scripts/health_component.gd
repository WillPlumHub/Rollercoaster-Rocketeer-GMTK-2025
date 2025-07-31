extends Node
class_name HealthComponent

var max_health: int = 5
@onready var health: int = max_health :
	get:
		return health
	set(val):
		if val < health:
			if val <= 0:
				val = health
				killed.emit()
			damaged.emit()
		elif val > health:
			if val > max_health:
				val = max_health
			healed.emit()
		health = val

signal healed
signal damaged
signal killed

var _parent: Node2D:
	get: return get_parent()


func _ready() -> void:
	if _parent is RigidBody2D:
		_parent.body_entered.connect(_on_body_entered)
		_parent.body_exited.connect(_on_body_entered)


func _on_body_entered(n: Node2D):
	if _parent is RigidBody2D:
		print("Owie! I got hit at a speed of %s" % _parent.linear_velocity)

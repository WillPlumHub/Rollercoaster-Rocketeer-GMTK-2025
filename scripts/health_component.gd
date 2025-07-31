extends Node
class_name HealthComponent

@export var impact_damage: bool = true
@export var max_health: int = 5
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

var _inv_timer: SceneTreeTimer


func _ready() -> void:
	if _parent is RigidBody2D:
		_parent.body_entered.connect(_on_body_entered)


func _on_body_entered(n: Node2D):
	if _parent is RigidBody2D && !_inv_timer:
		var damage = (_parent.linear_velocity / 10.0).length()
		if damage >= 50:
			_inv_timer = get_tree().create_timer(1.0, false, true, false)
			_inv_timer.timeout.connect(_on_timeout)
			health -= damage


func _on_timeout():
	_inv_timer = null

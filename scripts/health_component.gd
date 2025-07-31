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
	if _parent is RigidBody2D && !_inv_timer && impact_damage:
		# Raycast to get the normal of contact
		var space_state = _parent.get_world_2d().direct_space_state
		var start_pos = _parent.global_position
		var end_pos = _parent.global_position + (_parent.linear_velocity.normalized() * 1000.0)
		var query = PhysicsRayQueryParameters2D.create( 
			start_pos,
			end_pos,
			_parent.collision_mask, [_parent])
		var result = space_state.intersect_ray(query)
		#print(_parent.linear_velocity.normalized())
		
		if result:
			var damage = (_parent.linear_velocity * result.normal).length() / 10.0
			print("Contact from %s to %s" % [start_pos, result.position])
			print("%s took %s damage" % [_parent.name, floor(damage)])
			if damage >= 10:
				_inv_timer = get_tree().create_timer(1.0, false, true, false)
				_inv_timer.timeout.connect(_on_timeout)
				health -= damage
		#else:
			#print("No contact from %s to %s" % [start_pos, end_pos])


func _on_timeout():
	_inv_timer = null

@tool
extends Node
class_name GravityComponent

var _body: CharacterBody2D:
	get: return get_parent()

var in_gravity_field: bool = false
var center_point: Vector2 = Vector2.ZERO	# Just for spherical gravity
var gravity_force: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var up: Vector2 = Vector2.UP
var right: Vector2 = Vector2.RIGHT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _body && in_gravity_field:
		up = -(_body.position - center_point).normalized()
		right = up.rotated(-PI / 2.0)
		_body.up_direction = up


func _get_configuration_warnings() -> PackedStringArray:
	if get_parent() is not CharacterBody2D:
		return["Parent must be a CharacterBody2D!"]
	return []


static func get_gravity_component(n: Node) -> GravityComponent:
	for c in n.get_children():
		if c is GravityComponent:
			return c
	return null

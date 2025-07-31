extends Area2D
class_name HitBox2D

@export var _health_node: HealthComponent
var invincible: bool

signal hit


func damage(val: int):
	if !invincible:
		if _health_node:
			_health_node.damage(val)
		invincible = true
		get_tree().create_timer(1.0).timeout.connect(_on_invincibiliy_timeout)


func _on_invincibiliy_timeout():
	invincible = false

extends RigidBody2D

@export var rigid_body: RigidBody2D
@export var health_component: HealthComponent
@onready var thrusters: Thrusters = $Thrusters


var speed:float = -1
var _init: bool = false


func _ready() -> void:
	GameData.launch_train_cars.connect(_on_launch_train_cars)
	health_component.damaged.connect(GameData._on_playercart_damage)
	
	thrusters.power = 10
	thrusters.fuel = 3000


func _on_launch_train_cars() -> void:
	# IF SPEED IS -1 THEN IT IS A NEW CAR AND DOESNT CARE ABOUT KEEPING MOMENTUM
	_init = true


func _process(delta: float) -> void:
	if !_init: return

	position += Vector2(cos(rotation), sin(rotation))
	

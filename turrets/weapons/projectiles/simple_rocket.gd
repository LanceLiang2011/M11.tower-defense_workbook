@icon("res://icons/icon_rocket.svg")
class_name Rocket extends Area2D

@export var speed := 350.0
@export var max_travel_distance := 1000.0
@export var damage := 20.0

var _distance_traveled := 0.0


func _init() -> void:
	monitorable = false # undetectable by other areas
	z_as_relative = false

func _ready() -> void:
	_connect_signals()


func _physics_process(delta: float) -> void:
	var distance_to_travel := speed * delta
	_distance_traveled += distance_to_travel

	position += transform.x.normalized() * distance_to_travel

	_check_distance_traveled()


func _connect_signals() -> void:
	area_entered.connect(_on_area_entered)


func _check_distance_traveled() -> void:
	if _distance_traveled >= max_travel_distance:
		_explode()


func _explode() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Mob:
		var mob: Mob = area
		mob._take_damage(damage)
		_explode()

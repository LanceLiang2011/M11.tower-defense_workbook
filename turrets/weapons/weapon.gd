@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D

@export var mob_detection_range := 400.0

## Number of attacks per second
@export var attack_rate := 1.0

var _area_2d := _create_area_2d() # No need to onready as there's not dynamic initialization in _create_area_2d()
@onready var _collision_shape_2d := _create_collision_shape_2d()
@onready var _timer := _create_timer()

func _ready() -> void:
	_create_nodes()
	_connect_signals()
	_setup_nodes()


func _create_nodes() -> void:
	add_child(_area_2d)
	_area_2d.add_child(_collision_shape_2d)
	add_child(_timer)


func _connect_signals() -> void:
	_timer.timeout.connect(_attack)


func _setup_nodes() -> void:
	_timer.start()


func _create_area_2d() -> Area2D:
	var area := Area2D.new()

	area.monitoring = true
	area.monitorable = false

	return area


func _create_collision_shape_2d() -> CollisionShape2D:
	var shape := CollisionShape2D.new()

	var circle_shape := CircleShape2D.new()
	circle_shape.radius = mob_detection_range

	shape.shape = circle_shape

	return shape


func _create_timer() -> Timer:
	var timer := Timer.new()

	var wait_time := 1.0 / attack_rate
	timer.wait_time = wait_time

	return timer


func _attack() -> void:
	print("Base Attack!")

@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D

@export var mob_detection_range := 400.0
@export var attack_rate := 1.0

var _area_2d := _create_area_2d()
@onready var _collision_shape_2d := _create_collision_shape_2d()
@onready var _timer := _create_timer()

func _ready() -> void:
	_add_nodes()
	_connect_signals()
	_setup_nodes()


func _add_nodes() -> void:
	add_child(_area_2d)
	_area_2d.add_child(_collision_shape_2d)
	add_child(_timer)


func _connect_signals() -> void:
	_timer.timeout.connect(_attack)


func _setup_nodes() -> void:
	_timer.start()
	z_index = 10


func _create_area_2d() -> Area2D:
	var area_2d = Area2D.new()

	area_2d.monitoring = true
	area_2d.monitorable = false
	
	return area_2d


func _create_collision_shape_2d() -> CollisionShape2D:
	var collision_shape_2d := CollisionShape2D.new()
	var circle_shape := CircleShape2D.new()
	circle_shape.radius = mob_detection_range
	collision_shape_2d.shape = circle_shape

	return collision_shape_2d


func _create_timer() -> Timer:
	var timer = Timer.new()
	timer.wait_time = 1 / attack_rate

	return timer


func _attack() -> void:
	pass ## abstract method for override
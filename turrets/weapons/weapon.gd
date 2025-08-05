@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D

@export var mob_detection_range := 400.0

var _area_2d := _create_area_2d()
@onready var _collision_shape_2d := _create_collision_shape_2d()

func _ready() -> void:
	add_child(_area_2d)
	_area_2d.add_child(_collision_shape_2d)

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

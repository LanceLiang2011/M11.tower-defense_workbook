@icon("res://icons/icon_mob.svg")
class_name Mob extends Area2D

var max_health: float = 100

var _health: float

var health: float:
	get:
		return _health
	set(value):
		_health = clamp(value, 0, max_health)

		if _health_bar:
			_health_bar.value = _health
		
		if _health <= 0:
			_die()


var _health_bar: ProgressBar = null


func _ready() -> void:
	get_nodes()
	setup_nodes()


func get_nodes() -> void:
	_health_bar = %HealthBar


func setup_nodes() -> void:
	health = max_health


func take_damage(damage: float) -> void:
	health -= damage


func _die() -> void:
	queue_free()
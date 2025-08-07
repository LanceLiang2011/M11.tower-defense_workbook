@icon("res://icons/icon_mob.svg")
class_name Mob extends Area2D


var _tween: Tween = null

var max_health: float = 100

var _health: float

var health: float:
	get:
		return _health
	set(value):
		_health = clamp(value, 0, max_health)

		if _health_bar:
			if _tween:
				_tween.kill() # Stop any previous tween
			
			_tween = create_tween()
			_tween.tween_property(_health_bar, "value", _health, 0.3)

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
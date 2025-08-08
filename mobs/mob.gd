@icon("res://icons/icon_mob.svg")
class_name Mob extends Area2D

@export var speed: float = 100.0

var _tween: Tween = null
var max_health: float = 100


var health: float:
	get:
		return health
	set(value):
		health = clamp(value, 0, max_health)

		if _health_bar:
			if _tween:
				_tween.kill() # Stop any previous tween
			
			_tween = create_tween()
			_tween.tween_property(_health_bar, "value", health, 0.3)

		if health <= 0:
			_die()

@onready var _health_bar: ProgressBar = %HealthBar
@onready var _bar_pivot: Node2D = %BarPivot

func _ready() -> void:
	setup_nodes()


func _physics_process(_delta: float) -> void:
	_bar_pivot.global_rotation = 0.0 # Make sure the pivot won't rotate with path
	

func setup_nodes() -> void:
	health = max_health


func take_damage(damage: float) -> void:
	health -= damage
	var damage_indicator: DamageIndicator = preload("res://mobs/damage_indicator.tscn").instantiate()
	get_tree().current_scene.add_child(damage_indicator)
	damage_indicator.display_amount(damage)
	damage_indicator.global_position = global_position


func _die() -> void:
	queue_free()
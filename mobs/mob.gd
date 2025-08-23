@icon("res://icons/icon_mob.svg")
class_name Mob extends Area2D

@export var max_health := 100.0
@export var speed := 100.0

@onready var bar_pivot: Node2D = %BarPivot
@onready var health_bar: ProgressBar = %HealthBar

var health_bar_tween: Tween = null

var health: float:
	get = get_health, set = set_health


func _ready() -> void:
	health_bar.max_value = max_health
	health = max_health

func _physics_process(_delta: float) -> void:
	bar_pivot.global_rotation = 0.0

func get_health() -> float:
	return health


func set_health(value: float) -> void:
	var clamped_value = clampf(value, 0.0, 100.0)
	health = clamped_value

	if health_bar_tween != null:
		health_bar_tween.kill()
	
	health_bar_tween = create_tween()

	health_bar_tween.tween_property(health_bar, "value", health, 0.3)

	_check_death()


func _check_death() -> void:
	if health <= 0.0:
		_die()


func _take_damage(amount: float) -> void:
	health -= amount
	var damage_indicator: Node2D = preload("damage_indicator.tscn").instantiate()
	get_tree().current_scene.add_child(damage_indicator)
	damage_indicator.global_position = global_position
	damage_indicator.display_amount(amount)

func _die() -> void:
	queue_free()

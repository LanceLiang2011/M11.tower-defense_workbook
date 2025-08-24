extends Control

@onready var heart_container: HBoxContainer = %HeartContainer

const MAX_HEALTH: int = 5

var health: int:
	get = get_health, set = set_health


func _ready() -> void:
	health = MAX_HEALTH


func get_health() -> int:
	return health


func set_health(value: int) -> void:
	health = clamp(value, 0, MAX_HEALTH)

	for heart in heart_container.get_children():
		heart.visible = heart.get_index() < health
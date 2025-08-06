class_name SimpleRocket extends Area2D

@export var speed: float = 350.0
@export var max_distance: float = 1000.0

var _traveled_distance: float = 0.0

func _init():
	monitorable = false # the rocket is not detectable, it detects others


func _physics_process(delta: float) -> void:
	var distance_to_move: float = speed * delta
	_traveled_distance += distance_to_move

	position += transform.x.normalized() * distance_to_move

	check_distance()


func check_distance() -> void:
	if _traveled_distance >= max_distance:
		explode()


func explode() -> void:
	queue_free() # Remove the rocket from the scene for now TODO: add explosion effect
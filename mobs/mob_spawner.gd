class_name MobSpawner extends Node2D

@export var mob_packed_scene: PackedScene = preload("mob.tscn")
@export var interval_between_spawns: float = 2.0

@export var waves: Array[Dictionary] = [ {
	"mob_count": 5,
	"spawn_interval": 1.5
}, {
	"mob_count": 4,
	"spawn_interval": 0.8
}]

@onready var path_2d: Path2D = %Path2D

var timer := Timer.new()
var interval_timer := Timer.new()

var spawned_mobs: int = 0

var current_wave_index: int = 0


func _ready() -> void:
	setup_timer()
	setup_interval_timer()
	start_wave()


func setup_timer() -> void:
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)


func setup_interval_timer() -> void:
	add_child(interval_timer)
	interval_timer.wait_time = interval_between_spawns
	interval_timer.one_shot = true
	interval_timer.timeout.connect(_on_interval_timer_timeout)


func start_wave() -> void:
	timer.wait_time = get_current_wait_time()
	timer.start()


func prepare_next_wave() -> void:
	current_wave_index += 1
	spawned_mobs = 0

	if current_wave_index < waves.size(): interval_timer.start()
		

func spawn_mob() -> void:
	var mob_path_follow := MobPathFollow.new()
	var mob: Mob = mob_packed_scene.instantiate()

	path_2d.add_child(mob_path_follow)
	mob_path_follow.add_child(mob)
	mob_path_follow.mob = mob

func get_current_spawn_number() -> int:
	return waves[current_wave_index]["mob_count"]

func get_current_wait_time() -> float:
	return waves[current_wave_index]["spawn_interval"]

func _on_timer_timeout() -> void:
	spawn_mob()
	spawned_mobs += 1

	if spawned_mobs >= get_current_spawn_number():
		timer.stop()
		prepare_next_wave()


func _on_interval_timer_timeout() -> void:
	start_wave()

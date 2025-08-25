extends Control

signal health_depleted

@onready var heart_container: HBoxContainer = %HeartContainer
@onready var game_over_screen: ColorRect = %GameOverScreen
@onready var restart_button: Button = %RestartButton
@onready var game_win_screen: ColorRect = %GameWinScreen
@onready var quit_button: Button = %QuitButton

const MAX_HEALTH: int = 5

var health: int:
	get = get_health, set = set_health


func _ready() -> void:
	health = MAX_HEALTH
	game_over_screen.visible = false
	game_win_screen.visible = false
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_button.pressed.connect(get_tree().quit)


func get_health() -> int:
	return health


func set_health(value: int) -> void:
	health = clamp(value, 0, MAX_HEALTH)

	for heart in heart_container.get_children():
		heart.visible = heart.get_index() < health
	
	if health == 0:
		_show_game_over_screen()


func _show_game_over_screen() -> void:
	game_over_screen.visible = true
	get_tree().paused = true


func reset_health() -> void:
	health = MAX_HEALTH


func _on_restart_button_pressed() -> void:
	if not game_over_screen.visible:
		return

	reset_health()
	game_over_screen.visible = false
	get_tree().paused = false
	health_depleted.emit()


func _on_game_win() -> void:
	game_win_screen.visible = true
	get_tree().paused = true

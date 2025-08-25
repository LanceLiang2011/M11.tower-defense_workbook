extends Node2D

@onready var player_hurtbox: Area2D = %PlayerHurtbox
@onready var roads: TileMapLayer = %Roads

var _game_board: Dictionary[Vector2i, Turret] = {}

func _ready() -> void:
	player_hurtbox.area_entered.connect(
		func(_other_area: Area2D) -> void:
			PlayerUi.health -= 1
	)

	PlayerUi.health_depleted.connect(game_over)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_click"):
		_place_turret_on_mouse_position()


func _place_turret_on_mouse_position() -> void:
	var mouse_position := get_global_mouse_position()
	var tile_position := roads.local_to_map(mouse_position)

	if not _is_cell_valid(tile_position):
		return
		
	_place_turret(tile_position)


func _is_cell_valid(cell: Vector2i) -> bool:
	return not (_game_board.has(cell) or roads.get_cell_source_id(cell) != -1)


func game_over() -> void:
	get_tree().call_deferred("reload_current_scene")


func _place_turret(place_position: Vector2i) -> void:
	if _game_board.has(place_position):
		print("Position already occupied")
		return # already occupied
	
	# Add the turret
	var turret := Turret.new()
	_game_board[place_position] = turret
	add_child(turret)
	# Place the turret
	turret.global_position = roads.map_to_local(place_position)

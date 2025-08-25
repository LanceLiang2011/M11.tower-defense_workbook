extends Node2D

@onready var player_hurtbox: Area2D = %PlayerHurtbox

func _ready() -> void:
	player_hurtbox.area_entered.connect(
		func(_other_area: Area2D) -> void:
			PlayerUi.health -= 1
	)

	PlayerUi.health_depleted.connect(game_over)


func game_over() -> void:
	get_tree().call_deferred("reload_current_scene")
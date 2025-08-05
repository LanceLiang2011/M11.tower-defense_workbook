class_name SimpleCannon extends Weapon


func _physics_process(_delta: float) -> void:
	var nearest_mob := _get_nearest_mob()

	if nearest_mob != null:
		look_at(nearest_mob.global_position)

	$Mob.global_position = get_global_mouse_position() # TODO: Remove this temporary line for visualizing mouse position


func _get_nearest_mob() -> Area2D:
	var mobs_in_range := _area_2d.get_overlapping_areas()

	if mobs_in_range.is_empty():
		print("No mobs in range.")
		return null

	var nearest_mob: Area2D = mobs_in_range.front()

	print("Mobs in range: ", mobs_in_range.size())

	return nearest_mob
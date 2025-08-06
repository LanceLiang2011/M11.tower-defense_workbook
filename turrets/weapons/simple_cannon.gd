class_name SimpleCannon extends Weapon


func _physics_process(_delta: float) -> void:
	var nearest_mob := _get_nearest_mob()

	if nearest_mob != null:
		look_at(nearest_mob.global_position)

	$Mob.global_position = get_global_mouse_position() # TODO: Remove this temporary line for visualizing mouse position


func _get_nearest_mob() -> Area2D:
	var mobs_in_range := _area_2d.get_overlapping_areas()

	if mobs_in_range.is_empty():
		return null

	var nearest_mob: Area2D = mobs_in_range.front()

	return nearest_mob


## Override the _attack method from Weapon
func _attack() -> void:
	super._attack() # Call the base class method (optional)
	
	var nearest_mob := _get_nearest_mob()

	if nearest_mob != null:
		var rocket: Node2D = preload("res://turrets/weapons/projectiles/simple_rocket.tscn").instantiate()
		get_tree().current_scene.add_child(rocket) # Make sure to add the rocket to the scene tree
		rocket.global_transform = global_transform # Position and orient the rocket at the weapon's location
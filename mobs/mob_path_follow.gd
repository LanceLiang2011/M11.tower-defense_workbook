class_name MobPathFollow extends PathFollow2D

var mob: Mob = null: set = set_mob


func _ready() -> void:
	if mob == null and get_child_count() > 0:
		mob = get_child(0) as Mob


func _physics_process(delta: float) -> void:
	progress += mob.speed * delta


func set_mob(new_mob: Mob) -> void:
	mob = new_mob

	if mob != null:
		mob.tree_exited.connect(queue_free) # Make sure when mob leave the tree, this path follows also get removed
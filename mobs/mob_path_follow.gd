class_name MobPathFollow extends PathFollow2D

var mob: Mob = null: set = set_mob


func _ready() -> void:
	if mob == null and get_child_count() > 0:
		mob = get_child(0) as Mob # We assume the mob should be the direct child of the path


func _physics_process(delta: float) -> void:
	progress += mob.speed * delta

func set_mob(new_mob: Mob) -> void:
	mob = new_mob

	if mob != null:
		mob.tree_exited.connect(queue_free) # When mob is removed, it's path will be removed too. In this design, each mob should have one path follow node.

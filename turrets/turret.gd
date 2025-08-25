@tool
class_name Turret extends Sprite2D

@export var weapon_scene: PackedScene = preload("weapons/simple_canon.tscn"):
	set = set_weapon_scene

var weapon: Weapon = null


func _ready() -> void:
	set_weapon_scene(weapon_scene)
	texture = preload("turret_base.png")


func set_weapon_scene(new_scene: PackedScene) -> void:
	weapon_scene = new_scene

	# Remove previous weapon to avoid duplication
	if weapon != null:
		weapon.queue_free()

	if weapon_scene == null: return
	
	# Instantiate the new weapon and add it as a child
	var weapon_instance: Weapon = weapon_scene.instantiate()

	assert(
			weapon_instance is Weapon,
			"The weapon scene must inherit from Weapon."
		)


	add_child(weapon_instance) # weapon should be a direct child of turret
	weapon = weapon_instance

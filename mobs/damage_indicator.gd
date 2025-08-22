class_name DamageIndicator extends Node2D

@onready var label: Label = %Label


func display_amount(amount: int) -> void:
	position.x += randf_range(-24.0, 24.0) # Get some horizontal randomness
	label.text = str(amount)
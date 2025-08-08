class_name DamageIndicator extends Node2D

@onready var label: Label = %Label

func display_amount(amount: float) -> void:
	## Create a random horizontal shift
	position.x += randf_range(-32.0, 32.0)

	label.text = str(amount)
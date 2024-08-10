extends Control
class_name TowerSelector

@export var tower_placement_ref: Control

const BLUE_NINJA = preload("res://scenes/blue_ninja.tscn")

func _on_ninja_button_pressed():
	var ninja = BLUE_NINJA.instantiate()
	ninja.global_position = tower_placement_ref.global_position
	get_tree().root.add_child(ninja)
	
	tower_placement_ref.visible = false
	get_tree().paused = false
	visible = false

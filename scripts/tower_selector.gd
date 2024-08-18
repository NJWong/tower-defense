extends Control
class_name TowerSelector

@export var tower_placement_ref: Control

@onready var gold_counter: GoldCounter = get_node("/root/Game/CounterUI/GoldCounter")

const BLUE_NINJA = preload("res://scenes/blue_ninja.tscn")
const BLUE_NINJA_COST = 50

func _on_ninja_button_pressed():
	var ninja = BLUE_NINJA.instantiate()
	ninja.global_position = tower_placement_ref.global_position
	get_tree().root.add_child(ninja)
	gold_counter.sub_gold(BLUE_NINJA_COST)
	
	tower_placement_ref.visible = false
	get_tree().paused = false
	visible = false

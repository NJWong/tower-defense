extends Control
class_name TowerSelector

@export var tower_placement_ref: Control

@onready var gold_counter: GoldCounter = get_node("/root/Game/CounterUI/GoldCounter")

const BLUE_NINJA = preload("res://scenes/blue_ninja.tscn")
const SAGE = preload("res://scenes/sage.tscn")

func close_ui():
	tower_placement_ref.visible = false
	get_tree().paused = false
	visible = false

func _on_ninja_button_pressed():
	var ninja: BlueNinja = BLUE_NINJA.instantiate()
	ninja.global_position = tower_placement_ref.global_position
	get_tree().root.add_child(ninja)
	gold_counter.sub_gold(ninja.COST)
	
	close_ui()

func _on_sage_button_pressed():
	var sage: Sage = SAGE.instantiate()
	sage.global_position = tower_placement_ref.global_position
	get_tree().root.add_child(sage)
	gold_counter.sub_gold(sage.COST)
	
	close_ui()

func _on_cancel_button_pressed():
	close_ui()

extends Control
class_name TowerSelector

@export var tower_placement_ref: Control

@onready var gold_counter: GoldCounter = get_node("/root/Game/CounterUI/GoldCounter")

const BLUE_NINJA = preload("res://scenes/blue_ninja.tscn")
const SAGE = preload("res://scenes/sage.tscn")

func close_ui():
	get_tree().paused = false
	visible = false

func _on_ninja_button_pressed():
	var ninja: BlueNinja = BLUE_NINJA.instantiate()

	if ninja.COST > gold_counter.gold_count:
		ninja.queue_free()
		print("Not enough gold")
	else:
		ninja.global_position = tower_placement_ref.global_position
		get_tree().root.add_child(ninja)
		gold_counter.sub_gold(ninja.COST)
		
		tower_placement_ref.visible = false
		close_ui()

func _on_sage_button_pressed():
	var sage: Sage = SAGE.instantiate()
	
	if sage.COST > gold_counter.gold_count:
		sage.queue_free()
		print("Not enough gold")
	else:
		sage.global_position = tower_placement_ref.global_position
		get_tree().root.add_child(sage)
		gold_counter.sub_gold(sage.COST)
		
		tower_placement_ref.visible = false
		close_ui()

func _on_cancel_button_pressed():
	close_ui()

class_name TowerDetails

extends Control

@onready var gold_counter: GoldCounter = get_node("/root/Game/CounterUI/GoldCounter")
@onready var upgrade_button = $VBoxContainer/UpgradeButton

var tower_ref: Node2D
var tower_upgrades

func show_ui():
	get_tree().paused = true
	var cost = tower_upgrades[tower_ref.level + 1]["cost"]

	if tower_ref.level == 3:
		upgrade_button.text = "MAX LEVEL"
		upgrade_button.disabled = true
	elif tower_ref.level == 2:
		upgrade_button.text = "LVL.UP - %d" % cost
		
		if cost > gold_counter.gold_count:
			upgrade_button.disabled = true
		else:
			upgrade_button.disabled = false
	elif tower_ref.level == 1:
		upgrade_button.text = "LVL.UP - %d" % cost

		if cost > gold_counter.gold_count:
			upgrade_button.disabled = true
		else:
			upgrade_button.disabled = false
	
	visible = true
	
func hide_ui():
	visible = false
	get_tree().paused = false

func _on_cancel_button_pressed():
	hide_ui()

func _on_upgrade_button_pressed():
	tower_ref.upgrade()
	hide_ui()

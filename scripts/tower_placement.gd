extends Control

func _on_texture_button_pressed():
	var tower_selector: TowerSelector = get_node("/root/Game/TowerSelector")
	
	if tower_selector:
		if !tower_selector.visible:
			get_tree().paused = true
			tower_selector.visible = true
			tower_selector.tower_placement_ref = self

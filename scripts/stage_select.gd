extends Control

signal show_main_menu
signal start_stage

func _on_back_button_pressed() -> void:
	show_main_menu.emit()

func _on_stage_1_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

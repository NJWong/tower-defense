extends Control

signal show_stage_select

func _on_play_button_pressed() -> void:
	show_stage_select.emit()

func _on_options_button_pressed() -> void:
	print("Options")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

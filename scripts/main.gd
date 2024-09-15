extends Control

@onready var main_menu: Control = $MainMenu
@onready var stage_select: Control = $StageSelect

func _on_main_menu_show_stage_select() -> void:
	main_menu.visible = false
	stage_select.visible = true

func _on_stage_select_show_main_menu() -> void:
	stage_select.visible = false
	main_menu.visible = true

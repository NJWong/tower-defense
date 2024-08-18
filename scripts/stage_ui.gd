extends Control
class_name StageUI

@onready var play_pause_button = %PlayPauseButton
@onready var speed_button = %SpeedButton
@onready var start_button = %StartButton
@onready var wave_manager: WaveManager = get_node("/root/Game/WaveManager")

var currentSpeed = 1

func _on_button_pressed():
	if get_tree().paused:
		get_tree().paused = false
		play_pause_button.text = "PAUSE"
	else:
		get_tree().paused = true
		play_pause_button.text = "PLAY"

func _on_speed_button_pressed():
	if currentSpeed == 1:
		currentSpeed = 2
		Engine.time_scale = 2
		speed_button.text = "2 X"
	elif currentSpeed == 2:
		currentSpeed = 3
		Engine.time_scale = 3
		speed_button.text = "3 X"
	elif currentSpeed == 3:
		currentSpeed = 1
		Engine.time_scale = 1
		speed_button.text = "1 X"

func _on_start_button_pressed():
	wave_manager.start_wave()
	start_button.visible = false
	play_pause_button.visible = true

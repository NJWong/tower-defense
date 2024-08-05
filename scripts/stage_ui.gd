extends Control

@onready var play_pause_button = %PlayPauseButton
@onready var speed_button = %SpeedButton

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
		currentSpeed = 5
		Engine.time_scale = 5
		speed_button.text = "5 X"
	elif currentSpeed == 5:
		currentSpeed = 1
		Engine.time_scale = 1
		speed_button.text = "1 X"

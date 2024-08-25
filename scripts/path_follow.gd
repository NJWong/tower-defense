class_name MobPathFollow

extends PathFollow2D

@export var SPEED = 0

func _process(delta):
	progress += delta * SPEED

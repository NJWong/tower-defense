extends PathFollow2D

const SPEED = 30

func _process(delta):
	progress += delta * SPEED

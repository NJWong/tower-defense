extends Node2D

@onready var spawn_timer = $SpawnTimer

const FLAM = preload("res://scenes/flam.tscn")
const STAGE = preload("res://scenes/stages/stage_1_1.tscn")

var count = 1
const MAX_MOBS = 5

func _ready():
	if count <= MAX_MOBS && spawn_timer.is_stopped():
		spawn_timer.start()

func _on_timer_timeout():
	if count >= MAX_MOBS:
		spawn_timer.stop()
	
	var new_flam = FLAM.instantiate()
	new_flam.name = "Flam %d" % count
	var new_stage = STAGE.instantiate()
	
	new_stage.get_node("PathFollow2D").add_child(new_flam)
	add_child(new_stage)
	
	count += 1

extends Node2D
class_name WaveManager

const MOB_DICT = {
	"flam": preload("res://scenes/flam.tscn")
}

const STAGE_DICT = {
	"stage_1_1": preload("res://scenes/stages/stage_1_1.tscn")
}

const WAVES = {
	1: { "mob": "flam", "count": 10},
	2: { "mob": "flam", "count": 20},
}

@onready var spawn_timer = $SpawnTimer
@onready var game = get_node("/root/Game")
@onready var stage_ui: StageUI = get_node("/root/Game/StageUI")

var current_stage = "stage_1_1"
var wave_is_running = false
var current_wave = 1
var mob_count = 1
var kill_count = 0

func _process(delta):
	if wave_is_running:
		if kill_count == WAVES[current_wave]["count"]:
			wave_is_running = false
			handle_next_wave()

func _on_spawn_timer_timeout():
	var wave = WAVES[current_wave]
	
	if mob_count == wave["count"]:
		spawn_timer.stop()
	
	var new_flam = MOB_DICT[wave["mob"]].instantiate()
	var new_stage = STAGE_DICT[current_stage].instantiate()
	
	new_stage.get_node("PathFollow2D").add_child(new_flam)
	game.add_child(new_stage)
	new_flam.add_to_group("mobs")
	
	mob_count += 1

func start_wave():
	spawn_timer.start()
	wave_is_running = true
	
func stop_wave():
	spawn_timer.stop()
	wave_is_running = false

func handle_next_wave():
	current_wave += 1
	mob_count = 1
	kill_count = 0
	stage_ui.play_pause_button.visible = false
	stage_ui.start_button.visible = true
	
	if !WAVES.has(current_wave):
		# TODO proper game over handling
		print("GAME OVER")

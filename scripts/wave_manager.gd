extends Node2D
class_name WaveManager

const MOB_DICT = {
	"flam": preload("res://scenes/flam.tscn"),
	"lizard": preload("res://scenes/lizard.tscn"),
	"cyclops": preload("res://scenes/cyclops.tscn")
}

const STAGE_DICT = {
	"stage_1_1": preload("res://scenes/stages/stage_1_1.tscn")
}

const WAVES = {
	1: { "mob": "flam", "count": 5, "spawn_timer": 0.5 },
	2: { "mob": "flam", "count": 10, "spawn_timer": 0.5 },
	3: { "mob": "flam", "count": 15, "spawn_timer": 0.5 },
	4: { "mob": "lizard", "count": 5, "spawn_timer": 0.25 },
	5: { "mob": "lizard", "count": 10, "spawn_timer": 0.25 },
	6: { "mob": "lizard", "count": 15, "spawn_timer": 0.25 },
	7: { "mob": "cyclops", "count": 5, "spawn_timer": 0.5 },
	8: { "mob": "cyclops", "count": 10, "spawn_timer": 0.5 },
	9: { "mob": "cyclops", "count": 15, "spawn_timer": 0.5 },
	10: { "mob": "flam", "count": 30, "spawn_timer": 0.5 },
	11: { "mob": "lizard", "count": 30, "spawn_timer": 0.25 },
	12: { "mob": "cyclops", "count": 30, "spawn_timer": 0.5 },
}

@onready var spawn_timer = $SpawnTimer
@onready var game = get_node("/root/Game")
@onready var stage_ui: StageUI = get_node("/root/Game/StageUI")
@onready var mobs = $Mobs

var current_stage = "stage_1_1"
var wave_is_running = false
var current_wave = 1
var mob_count = 1
var kill_count = 0
var escape_count = 0

func _process(delta):
	if wave_is_running:
		if kill_count + escape_count == WAVES[current_wave]["count"]:
			wave_is_running = false
			handle_next_wave()

func _on_spawn_timer_timeout():
	var wave = WAVES[current_wave]
	
	if mob_count == wave["count"]:
		spawn_timer.stop()
	
	var new_mob = MOB_DICT[wave["mob"]].instantiate()
	var new_stage = STAGE_DICT[current_stage].instantiate()
	var stage_mob_path_follow: MobPathFollow = new_stage.get_node("PathFollow2D")
	stage_mob_path_follow.SPEED = new_mob.SPEED
	
	stage_mob_path_follow.add_child(new_mob)
	mobs.add_child(new_stage)
	
	mob_count += 1

func start_wave():
	var wave = WAVES[current_wave]
	spawn_timer.wait_time = wave["spawn_timer"]
	spawn_timer.start()
	wave_is_running = true
	
func stop_wave():
	spawn_timer.stop()
	wave_is_running = false

func handle_next_wave():
	current_wave += 1
	mob_count = 1
	kill_count = 0
	escape_count = 0
	stage_ui.play_pause_button.visible = false
	stage_ui.start_button.visible = true
	
	if !WAVES.has(current_wave):
		# TODO proper game over handling
		print("GAME OVER")
	else:
		print("Wave finished")

class_name Cyclops

extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var path_follow: PathFollow2D = get_parent()
@onready var health_bar = $HealthBar
@onready var gold_counter: GoldCounter = get_node("/root/Game/CounterUI/GoldCounter")
@onready var wave_manager: WaveManager = get_node("/root/Game/WaveManager")

const SMOKE = preload("res://scenes/attacks/smoke.tscn")
const MAX_HEALTH = 120
const GOLD_REWARD = 30
const SPEED = 30

var previous_position = Vector2.ZERO
var health: int

func _ready():
	health_bar.max_value = MAX_HEALTH
	health_bar.visible = false
	health = MAX_HEALTH

func _process(delta):
	# Check if escaped
	if path_follow.progress_ratio == 1:
		wave_manager.escape_count += 1
		get_parent().get_parent().queue_free()
	
	# Update along path
	var current_position = path_follow.position
	var direction = (current_position - previous_position).normalized()
	
	if direction.x > 0:
		animated_sprite.play("walk_right")
	elif direction.x < 0:
		animated_sprite.play("walk_left")
	elif direction.y > 0:
		animated_sprite.play("walk_down")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	
	previous_position = current_position
	
	# Show health bar if damage taken
	if !health_bar.visible && health < MAX_HEALTH:
		health_bar.visible = true
		
	# Update health
	health_bar.value = health

func take_damage(damage: int):
	health -= damage
	
	if health <= 0:
		wave_manager.kill_count += 1
		gold_counter.add_gold(GOLD_REWARD)
		var smoke = SMOKE.instantiate()
		smoke.global_position = global_position
		get_tree().root.add_child(smoke)
		get_parent().get_parent().queue_free()
		
	animated_sprite.modulate = Color.DARK_RED
	await get_tree().create_timer(0.1).timeout
	animated_sprite.modulate = Color.WHITE

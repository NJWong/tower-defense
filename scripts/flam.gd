class_name Flam

extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var path_follow: PathFollow2D = get_parent()
@onready var health_bar = $HealthBar

const SMOKE = preload("res://scenes/attacks/smoke.tscn")
const MAX_HEALTH = 25

var previous_position = Vector2.ZERO
var health: int

func _ready():
	health_bar.visible = false
	health = MAX_HEALTH

func _process(delta):
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
		var smoke = SMOKE.instantiate()
		smoke.global_position = global_position
		get_tree().root.add_child(smoke)
		queue_free()
		
	animated_sprite.modulate = Color.DARK_RED
	await get_tree().create_timer(0.1).timeout
	animated_sprite.modulate = Color.WHITE

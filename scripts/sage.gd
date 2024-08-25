class_name Sage

extends Node2D

@onready var attack_range = $AttackRange
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_cooldown = $AttackCooldown

const ROCK = preload("res://scenes/attacks/rock.tscn")
const COST = 120

var damage: int = 10
var targets: Array[Node2D] = []

func sort_progress(a: Node2D, b: Node2D):
	var path_follow_a: PathFollow2D = a.get_parent()
	var path_follow_b: PathFollow2D = b.get_parent()
	
	if path_follow_b.progress < path_follow_a.progress:
		return true
	return false

func _process(delta):
	var mobs_in_range: Array[Node2D] = attack_range.get_overlapping_bodies()
	mobs_in_range.sort_custom(sort_progress)
	
	# Save local reference to targets
	targets = mobs_in_range
	
	if targets.size() > 0 && attack_cooldown.is_stopped():
		attack()

func attack():
	var first_target = targets[0]
	
	# Attack direction
	var angle = rad_to_deg(get_angle_to(first_target.global_position))
	
	if angle > -135 && angle < -45:
		animated_sprite.play("attack_up")
	elif angle > 45 && angle < 135:
		animated_sprite.play("attack_down")
	elif (angle >= -180 && angle <= -135) || (angle >= 135 && angle <= 180):
		animated_sprite.play("attack_left")
	elif (angle >= -45 && angle <= 0) || (angle >= 0 && angle <= 45):
		animated_sprite.play("attack_right")

	var rock = ROCK.instantiate()
	rock.global_position = global_position
	
	var game = get_tree().root
	game.add_child(rock)
	
	for target in targets:
		if target.has_method('take_damage'):
			target.take_damage(damage)
	
	# Start attack cooldown
	if attack_cooldown.is_stopped():
		attack_cooldown.start()

func _on_attack_cooldown_timeout():
	if targets.size() > 0:
		attack()
	else:
		# Stop the cooldown if there is no target
		attack_cooldown.stop()

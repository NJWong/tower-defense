extends Node2D

@onready var attack_range = $AttackRange
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_cooldown = $AttackCooldown

const CLAW = preload("res://scenes/attacks/claw.tscn")

var damage: int = 10
var target: Node2D

func sort_progress(a: Flam, b: Flam):
	var path_follow_a: PathFollow2D = a.get_parent()
	var path_follow_b: PathFollow2D = b.get_parent()
	
	if path_follow_b.progress < path_follow_a.progress:
		return true
	return false

func _process(delta):
	var targets: Array[Node2D] = attack_range.get_overlapping_bodies()

	if targets.size() == 1:
		target = targets[0]
	elif targets.size() > 1:
		targets.sort_custom(sort_progress)
		target = targets[0]
	else:
		target = null

	# Start attacking if not on cooldown
	if target && attack_cooldown.is_stopped():
		attack(target)

func attack(target: Node2D):
	if target.has_method("take_damage"):
		# Attack direction
		var angle = rad_to_deg(get_angle_to(target.global_position))
		
		if angle > -135 && angle < -45:
			animated_sprite.play("attack_up")
		elif angle > 45 && angle < 135:
			animated_sprite.play("attack_down")
		elif (angle >= -180 && angle <= -135) || (angle >= 135 && angle <= 180):
			animated_sprite.play("attack_left")
		elif (angle >= -45 && angle <= 0) || (angle >= 0 && angle <= 45):
			animated_sprite.play("attack_right")
			
		var claw = CLAW.instantiate()
		claw.global_position = target.global_position
		if target.global_position.x < global_position.x:
			claw.get_node("AnimatedSprite2D").flip_h = true
		
		var game = get_tree().root
		game.add_child(claw)
		
		# Damage enemy
		target.take_damage(damage)
	
	# Start attack cooldown
	if attack_cooldown.is_stopped():
		attack_cooldown.start()

func _on_attack_cooldown_timeout():
	if target:
		attack(target)
	else:
		# Stop the cooldown if there is no target
		attack_cooldown.stop()

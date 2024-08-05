extends Node2D

@onready var attack_range = $AttackRange
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_cooldown = $AttackCooldown

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
		print('attacking:', target.name)
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

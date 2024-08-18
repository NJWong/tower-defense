extends Control
class_name GoldCounter

@onready var counter_label = $CounterLabel

var gold_count = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	counter_label.text = str(gold_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if str(gold_count) != counter_label.text:
		counter_label.text = str(gold_count)

func add_gold(gold):
	gold_count += gold
	
func sub_gold(gold):
	gold_count -= gold

extends Node2D

var queue_spots: Array[Node]  # Actually Array[Marker2D] but the type system can't narrow it -_-

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_spots = get_children()
	print(queue_spots)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

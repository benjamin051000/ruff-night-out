extends Node2D

const Guest = preload("res://src/characters/guest.gd")  # apparently this gives us the type

@export var light_sprite_threshold := 3

var queue_spots: Array[Node]  # Actually Array[Marker2D] but the type system can't narrow it -_-
## A literal Queue. idx 0 is the front of the line.
var queue: Array[Guest]

func empty() -> int:
	return queue.size() == 0

func get_current_guest() -> Guest:
	return queue[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_spots = get_children()


## Add a guest to the queue line.
func add_guest(guest: Guest) -> void:
	queue.append(guest)
	# If we're out of space, just stick it off-screen.
	if queue.size() > queue_spots.size():
		guest.position.x = -100
	else:
		# Find the next open one
		var marker: Marker2D = queue_spots[queue.size()-1]
		guest.rest_point_bottom = marker.position
		if queue.size()-1 < light_sprite_threshold:
			guest.set_sprite("light")
	guest.in_queue = true


## Remove a guest from the queue, either by letting them into the club
## or kicking them to the curb.
func remove_guest(accepted: bool) -> void:
	var guest := get_current_guest()
	if accepted:
		guest.enter_door()
	else: 
		guest.rest_point_bottom.x = 1920*1.5
	queue.pop_front()
	
	if queue.is_empty():
		Global.start_endgame.emit()
		return
	
	# Goes front to back through the queue.
	# But only do it for the first 9 spots.
	for i in min(queue_spots.size(), queue.size()):
		var g := queue[i]
		var new_rest_point_bottom := queue_spots[i]
		g.rest_point_bottom = new_rest_point_bottom.position
		if i < light_sprite_threshold:
			g.set_sprite("light")

extends Node2D

const Guest = preload("res://src/characters/guest.gd")  # apparently this gives us the type

@export var light_sprite_threshold := 3

var queue_spots: Array[Node]  # Actually Array[Marker2D] but the type system can't narrow it -_-
## A literal Queue. idx 0 is the front of the line.
var queue: Array[Guest]

func get_current_guest() -> Guest:
	return queue[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.new_guest_spawned.connect(_on_new_guest_spawned)
	Global.guest_left_queue.connect(_on_guest_left_the_queue)
	queue_spots = get_children()
	pass


func _on_new_guest_spawned(guest: Guest) -> void:
	queue.append(guest)
	# If we're out of space, just stick it off-screen.
	if queue.size() > queue_spots.size():
		guest.position.x = -100
	else:
		# Find the next open one
		var marker: Marker2D = queue_spots[queue.size()-1]
		guest.rest_point_bottom = marker.position
		if queue.size()-1 < light_sprite_threshold:
			guest.sprite.play("light")
	guest.in_queue = true


func _on_guest_left_the_queue(accepted: bool) -> void:
	# TODO advance everyone else forward in the queue.
	# Basically just update their rest points.
	var guest := get_current_guest()
	if accepted:
		guest.rest_point_bottom.x = 1625  # TODO eyeballed
	else: 
		guest.rest_point_bottom.x = 1920*1.5
	queue.pop_front()
	
	# Goes front to back through the queue.
	# But only do it for the first 9 spots.
	for i in min(queue_spots.size(), queue.size()):
		var g := queue[i]
		var new_rest_point_bottom := queue_spots[i]
		g.rest_point_bottom = new_rest_point_bottom.position
		if i < light_sprite_threshold:
			g.sprite.play("light")

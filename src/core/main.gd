extends Node2D

## When this hits 0, game over!
var strikes := 3

enum Minigames {PIC_RESPONSE, ID_CHECK}

@onready var bouncer: Node2D = $Bouncer
@onready var door: Node2D = $Door
@onready var queue: Node2D = $Queue
@onready var guests: Node2D = $Guests

@onready var door_camera: Camera2D = $DoorCamera
@onready var full_camera: Camera2D = $FullCamera
@onready var actual_camera: Camera2D = $ActualCamera


## Move actual_camera to one of the "preset" cameras.
func move_camera(to: Camera2D) -> void:
	const t := 2.0
	var zoom_tween := create_tween()
	var pos_tween := create_tween()
	zoom_tween.tween_property(actual_camera, "zoom", to.zoom, t).set_trans(Tween.TRANS_SINE)
	pos_tween.tween_property(actual_camera, "position", to.position, t).set_trans(Tween.TRANS_SINE)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	intro()
	
func intro() -> void:
	door.open()
	await get_tree().create_timer(1).timeout
	bouncer.exit_door()
	await get_tree().create_timer(1).timeout
	door.close()
	move_camera(full_camera)
	spawn_guests()


func spawn_guests() -> void:
	const guest_scn := preload("res://src/characters/guest.tscn")
	for i in Global.NUM_GUESTS:
		var guest := guest_scn.instantiate()
		guest.scale = Vector2(10, 10)
		guests.add_child(guest)
		queue.add_guest(guest)


func _on_accept_button_pressed() -> void:
	bouncer.step_back()
	door.open()
	await get_tree().create_timer(1).timeout
	queue.remove_guest(true)
	await get_tree().create_timer(.5).timeout
	door.close()
	bouncer.step_forward()


func _on_reject_button_pressed() -> void:
	queue.remove_guest(false)

extends Node2D

var guests: Array
@onready var guest1: Node2D = $Guests/Guest
@onready var guest2: Node2D = $Guests/Guest2
@onready var guest3: Node2D = $Guests/Guest3

@onready var queue: Node2D = $Queue

## When this hits 0, game over!
var strikes := 3

enum Minigames {PIC_RESPONSE, ID_CHECK}

@onready var bouncer: Node2D = $Bouncer
@onready var door: Node2D = $Door

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
	door.door_opened.connect(func():
		bouncer.visible = true
		await get_tree().create_timer(1).timeout
		door.close()
		move_camera(full_camera)
	)
	await get_tree().create_timer(1).timeout
	door.open()
	
	await get_tree().create_timer(2).timeout
	Global.new_guest_spawned.emit(guest1)
	await get_tree().create_timer(.2).timeout
	Global.new_guest_spawned.emit(guest2)
	await get_tree().create_timer(.2).timeout
	Global.new_guest_spawned.emit(guest3)


func _on_accept_button_pressed() -> void:
	Global.guest_left_queue.emit(true)

func _on_reject_button_pressed() -> void:
	Global.guest_left_queue.emit(false)

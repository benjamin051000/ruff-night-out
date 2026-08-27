extends Node2D

const Guest = preload("res://src/characters/guest.tscn")
var guests: Array

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
		door.close()
		move_camera(full_camera)
	)
	door.open()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("pressed")

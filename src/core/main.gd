extends Node2D

## When this hits 0, game over!
var strikes := 3

enum Minigames {PIC_RESPONSE, ID_CHECK}

@onready var black_fade_in: ColorRect = $BlackFadeIn
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
	

const beat_interval := 60.0/124

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_fade_in.visible = true
	start_club_light($ClubLight)
	#await get_tree().create_timer(beat_interval).timeout
	start_club_light($ClubLight2)
	intro()

func start_club_light(light: Light2D) -> void:
	var colors := [
	Color.MAGENTA,
	Color.CYAN,
	Color(1, 0.3, 0.6),
	Color(0.3, 1, 0.5),
	Color(1, 0.8, 0.1),
	Color(0.6, 0.2, 1),
	Color(1, 0.2, 0.2),
	Color(0.2, 0.6, 1),
	Color(1, 0.5, 0.0),
	]
	var flash_time := beat_interval * 0.15   # fast hit to white
	var settle_time := beat_interval * 0.85  # slower fade to color

	var tween := create_tween().set_loops()
	for base_color in colors:
		tween.tween_property(light, "color", Color(.8,.8,.8), flash_time) \
			.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(light, "color", base_color, settle_time) \
			.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func intro() -> void:
	# Fade in
	var fade_in := create_tween()
	fade_in.tween_property(black_fade_in, "modulate:a", 0, 2)
	await fade_in.finished
	black_fade_in.queue_free()
	
	# Cutscene
	door.open()
	await get_tree().create_timer(1).timeout
	bouncer.exit_door()
	bouncer.step_back()
	
	# TODO manager says "Dogs only." placeholder wait 1s
	await get_tree().create_timer(1).timeout
	
	bouncer.step_forward()
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

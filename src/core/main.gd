extends Node2D

var misses := 0

const Guest = preload("uid://cub3q0665kin3")

var minigames: Array
var minigame  # randomly selected from ^^^
var dogtype  # saved to check @ button press if you were correct

@onready var black_fade_in: ColorRect = $BlackFadeIn
@onready var boss: Node2D = $Boss
@onready var bouncer: Node2D = $Bouncer
@onready var door: Node2D = $Door
@onready var queue: Node2D = $Queue
@onready var guests: Node2D = $Guests

@onready var door_camera: Camera2D = $DoorCamera
@onready var full_camera: Camera2D = $FullCamera
@onready var actual_camera: Camera2D = $ActualCamera

@onready var id_check: Node2D = $Minigames/IdCheck
@onready var reaction: Node2D = $Minigames/Reaction
@onready var dialogue: Node2D = $Minigames/Dialogue

## Move actual_camera to one of the "preset" cameras.
func move_camera(to: Camera2D) -> void:
	const t := 2.0
	var zoom_tween := create_tween()
	var pos_tween := create_tween()
	zoom_tween.tween_property(actual_camera, "zoom", to.zoom, t).set_trans(Tween.TRANS_SINE)
	pos_tween.tween_property(actual_camera, "position", to.position, t).set_trans(Tween.TRANS_SINE)

@onready var bouncer_speech_bubble: MarginContainer = $BouncerSpeechBubble
@onready var guest_speech_bubble: MarginContainer = $GuestSpeechBubble



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.guest_ready_for_minigame.connect(_on_guest_ready_for_minigame)
	minigames = [id_check, dialogue, reaction]
	
	Global.bouncer_bubble.connect(bouncer_speech_bubble.on_bubble_display)
	Global.guest_bubble.connect(guest_speech_bubble.on_bubble_display)
	Global.start_endgame.connect(on_endgame)
	Global.set_buttons_enabled.connect(_on_set_buttons_enabled)
	
	dialogue.hide_dialogue_bubbles.connect(func(): 
		bouncer_speech_bubble.visible = false
		guest_speech_bubble.visible = false
	)
	
	# Start the actual game
	black_fade_in.visible = true
	start_club_light($ClubLight)
	#await get_tree().create_timer(beat_interval).timeout
	start_club_light($ClubLight2)
	await intro()
	await get_tree().create_timer(2).timeout
	spawn_guests()


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
	var flash_time := Global.beat_interval * 0.15   # fast hit to white
	var settle_time := Global.beat_interval * 0.85  # slower fade to color

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
	await bouncer.step_forward()
	bouncer.face_right()
	
	await get_tree().create_timer(1).timeout
	await boss.exit_door()
	
	$BossSpeechBubble.on_bubble_display("...and remember, dogs only!", "higher")
	await get_tree().create_timer(2).timeout
	$BossSpeechBubble.queue_free()
	boss.enter_door()
	bouncer.step_back()
	#bouncer.step_back()
	bouncer.face_left()
	
	#bouncer.step_forward()
	door.close()
	move_camera(full_camera)


func spawn_guests() -> void:
	print("BOOM")
	const guest_scn := preload("res://src/characters/guest.tscn")
	for i in Global.NUM_GUESTS:
		var guest := guest_scn.instantiate()
		guest.scale = Vector2(10, 10)
		guests.add_child(guest)
		var vol_tween := create_tween()
		vol_tween.tween_property($CrowdNoise, "volume_db", 0, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		queue.add_guest(guest)


func _on_guest_ready_for_minigame(guest: Guest) -> void:
	bouncer.speak()
	dogtype = guest.dogtype
	minigame = minigames.pick_random()
	_on_set_buttons_enabled(false)
	minigame.start_minigame(dogtype)


func _on_accept_button_pressed() -> void:
	_on_set_buttons_enabled(false)
	const icon := preload("res://assets/buttons/px_buttonletin_click.png")
	$AcceptButton.icon = icon
	
	if dogtype == Global.DogType.FAKE:
		print("you missed")
		misses += 1
		$NegativeButtonSound.play()
		
	if dogtype == Global.DogType.REAL:
		$PositiveButtonSound.play()
		if minigame == dialogue:
			Global.play_final_dialogue.emit()
			await get_tree().create_timer(dialogue.t).timeout
	
	$BouncerSpeechBubble.visible = false
	minigame.cleanup()
	
	bouncer.step_back()
	door.open()
	await get_tree().create_timer(1).timeout
	queue.remove_guest(true)
	await get_tree().create_timer(.5).timeout
	door.close()
	bouncer.step_forward()


func _on_reject_button_pressed() -> void:
	_on_set_buttons_enabled(false)
	
	const icon := preload("res://assets/buttons/px_buttonbounce_click.png")
	$RejectButton.icon = icon
	if dogtype == Global.DogType.REAL:
		print("you missed")
		misses += 1
		$NegativeButtonSound.play()
		
	if dogtype == Global.DogType.FAKE:
		$PositiveButtonSound.play()
		if minigame == dialogue:
			Global.play_final_dialogue.emit()
			await get_tree().create_timer(dialogue.t).timeout
		
	$BouncerSpeechBubble.visible = false
	minigame.cleanup()
	queue.remove_guest(false)


func on_endgame() -> void:
	bouncer.idle()
	var vol_tween := create_tween()
	vol_tween.tween_property($BackgroundMusic, "volume_db", -80, 3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	vol_tween.tween_property($BackgroundMusicLayers, "volume_db", -80, 3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	vol_tween.parallel().tween_property($CrowdNoise, "volume_db", -80, 3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	await vol_tween.finished
	$ClubLight.queue_free()
	$ClubLight2.queue_free()
	
	await bouncer.step_forward()
	bouncer.face_right()
	door.open()
	await boss.exit_door()
	
	await get_tree().create_timer(2).timeout
	
	print(misses, "/", Global.NUM_GUESTS, " incorrect...")
	var percent_miss := float(misses) / Global.NUM_GUESTS
	if percent_miss > 1 - Global.WIN_CUTOFF:
		$BossSpeechBubble2.on_bubble_display("That's it, you're fired!", "higher")
	else:
		$BossSpeechBubble2.on_bubble_display("Nice work! You're a good boy!", "higher")


func _on_accept_button_mouse_entered() -> void:
	const icon := preload("res://assets/buttons/px_buttonletin_hover.png")
	$AcceptButton.icon = icon

func _on_accept_button_mouse_exited() -> void:
	const icon := preload("res://assets/buttons/px_buttonletin.png")
	$AcceptButton.icon = icon


func _on_reject_button_mouse_entered() -> void:
	const icon := preload("res://assets/buttons/px_buttonbounce_hover.png")
	$RejectButton.icon = icon
	

func _on_reject_button_mouse_exited() -> void:
	const icon := preload("res://assets/buttons/px_buttonbounce.png")
	$RejectButton.icon = icon

func _on_set_buttons_enabled(enabled: bool):
	$AcceptButton.disabled = not enabled
	$RejectButton.disabled = not enabled
	if enabled:
		_on_accept_button_mouse_exited()
		_on_reject_button_mouse_exited()

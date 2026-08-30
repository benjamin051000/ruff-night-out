extends Node2D

@onready var speech_bubble: MarginContainer = $SpeechBubble
@export var dogtype: Global.DogType
var rand_minigame
var dialogue 

var in_queue := false
var sent_minigame_signal := false

## Rest point, at the bottom of the sprite (their feet)
var rest_point_bottom: Vector2

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func talk(dogType):  #for initial greeting to bouncer
	const real_speech = ["I am real dog.","RealDog greeting 2", 
		"RealDog greeting 3", "RealDog greeting 4", "RealDog greeting 5"]
	const fake_speech = ["I hate pets!","NotDog greeting 2",
		"NotDog greeting 3","NotDog greeting 4", "NotDog greeting 5"]
	if dogType == Global.DogType.REAL:
		return speech_bubble.display_text(real_speech.pick_random())
	else:
		return speech_bubble.display_text(fake_speech.pick_random())


func _process(delta: float) -> void:
	const sprite_height := 34  # measured via ruler
	if in_queue:
		position.y = rest_point_bottom.y - sprite_height/2.0 * scale.y
		position.x = lerp(position.x, rest_point_bottom.x, 2*delta)
		if abs(position.x - 1400) < 10 and not sent_minigame_signal: # TODO this is the x val of the right-most Marker2D, copied here for haste.
			sent_minigame_signal = true
			Global.guest_ready_for_minigame.emit(self)


func enter_door() -> void:
	in_queue = false
	const door_x := 1600  # eyeballed
	var tween := create_tween()
	tween.tween_property(self, "position:x", door_x, 0.5)
	tween.tween_callback(func(): z_index = -9)
	tween.tween_property(self, "modulate:a", 0, 0.5)
	tween.parallel().tween_property(self, "scale", scale/1.2, 0.5)
	tween.tween_callback(queue_free)


func _ready() -> void:
	if  randf() >= Global.FAKE_RATE:
		dogtype = Global.DogType.REAL
	else:
		dogtype = Global.DogType.FAKE
	sprite.play()
	#need to talk in the speech bubble depending on dogtype
	#dialogue = talk(dogtype)
	#
	## determine minigame they will play
	#rand_minigame = randi_range(1,3)
	#if rand_minigame == 1:
		#idc.start_idcheck_minigame(dogtype)
	#elif rand_minigame == 2:
		#picresp.start(dogtype) #placeholder function
	#else:
		#speechtest.start(dogtype) #placeholder function
	
	# need to decide what all is called for each new guest walking up
	
	# need variable for bouncers guess, need to compare to guest.dogtype
		# would this go in main?
	
	# guest action response based on going in door vs turned away

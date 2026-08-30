extends Node2D

var cellphone = preload("res://assets/minigame/cellphone.png")
var bone = preload("res://assets/minigame/bone.png")
var squirrel = preload("res://assets/minigame/squirrel.png")
var money = preload("res://assets/minigame/money.png")
var laptop = preload("res://assets/minigame/laptop.png")
var cat = preload("res://assets/minigame/cat.png")
var tennisball = preload("res://assets/minigame/tennisball.png")
var treat = preload("res://assets/minigame/treat.png")

var guestresponse 
var Guest
var dogtype

# 1 is dog negative response, 0 is dog positive response
var expectedResponse = {
	cellphone : 1,
	bone : 0,
	squirrel : 0,
	money : 1,
	laptop : 1,
	cat : 1,
	tennisball : 0,
	treat : 0}

func get_random_items(count:int) -> Array:
	# creates an array of items based on the amount of cards shown
	var keys = expectedResponse.keys()
	keys.shuffle()
	return keys.slice(0, count)

const bouncertext := [
	"Hey, do you mind taking a look at this?",
	"My thoughts exactly.",
	"Uh huh, very interesting. Take a walk!"
]
# bouncertext[0] = always at start of minigame
# bouncertext[1] = if accept button is pressed
# bouncertext[2] = if reject button is pressed

# speechbubble call logic? May need changed/signals adjusted
# var i := 0
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.is_pressed():
		#if i >= text.size():
			#get_tree().quit()  # Not instant, so return too
			#return
#
		#$SpeechBubble.display(text[i])
		#i += 1
		

# function to display corresponding images on bouncer whiteboard
func assign_to_whiteboard(items:Array):
	$Whiteboard/TextureRect.texture = items[0]
	$Whiteboard/TextureRect2.texture = items[1]
	$Whiteboard/TextureRect3.texture = items[2]
	$Whiteboard/TextureRect.visible = false
	$Whiteboard/TextureRect2.visible = false
	$Whiteboard/TextureRect3.visible = false

func reveal_whiteboard_items() -> void:
	var rects = [
		$Whiteboard/TextureRect,
		$Whiteboard/TextureRect2,
		$Whiteboard/TextureRect3
	]


	for rect in rects:
		rect.visible = true
		if rect.get_node("AnimationPlayer").has_animation("item_pop"):
			$Whiteboard/TextureRect/AnimationPlayer.play("item_pop")
		await get_tree().create_timer(0.5).timeout


func show_whiteboard_sequence(items:Array) -> void:
	$"../Bouncer/AnimatedSprite2D".play("arm_raise")
	await get_tree().create_timer(0.6).timeout
	assign_to_whiteboard(items)
	$Whiteboard.visible = true
	await reveal_whiteboard_items()
	$"../Bouncer/AnimatedSprite2D".play("idle")
	

func get_guest_responses(items:Array) -> Array:
	var result = []
	# for each item, gives response based on dogtype
	for item in items:
		var expected = expectedResponse[item]

		if dogtype == Guest.DogType.REAL:
			result.append(expected)       # REALdog gives correct answer
		else:
			result.append(1 - expected)   # FAKEdog gives opposite answer

	return result

var like_response = preload("res://assets/minigame/heart.png")
var dislike_response = preload("res://assets/minigame/redx.png")

var actual_responses = {
	like_response : 0,
	dislike_response : 1 
}

func display_guest_resp(result: Array) -> void:
	var rects = [
		$GuestResp/Response1,
		$GuestResp/Response2
	]
	for r in rects:
		r.visible = false

	for i in range(result.size()):
		var value = result[i]
		# Find which image matches value
		var img = null
		for key in actual_responses.keys():
			if actual_responses[key] == value:
				img = key
				break
		# Assign the correct speech bubble image
		rects[i].texture = img
		rects[i].visible = true
		await get_tree().create_timer(0.5).timeout


func start_reaction_test(dogtype):
	$Whiteboard.visible = false
	dogtype = dogtype
	const SPEECH_BUBBLE = preload("res://src/minigames/speech_bubble.tscn")
	var bubble = SPEECH_BUBBLE.instantiate()
	add_child(bubble)

	bubble.display(bouncertext[0])
	var items = get_random_items(3)
	show_whiteboard_sequence(items)

	guestresponse = get_guest_responses(items)
	bubble.bubble_style = bubble.BubbleStyle.GUEST

func _ready() -> void:
	Guest = preload("res://src/characters/guest.tscn").instantiate()
	dogtype = Guest.dogtype
	
	
	

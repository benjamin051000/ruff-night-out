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
	print("grabbing items, assigning to array, scramble, pulling 3")
	var keys = expectedResponse.keys()
	keys.shuffle()
	return keys.slice(0, count)

const bouncertext := [
	"Hey, do you mind taking a look at this?",
	"Tell me what you think about these items.",
	"Quick question, what do you think of these?"
]


# function to display corresponding images on bouncer whiteboard
func assign_to_whiteboard(items:Array):
	print("Whiteboard item textures assigned")
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
		print("revealing whiteboard item")
		## animation optional
		#var anim = rect.get_node("AnimationPlayer")
		#if anim and anim.has_animation("item_pop"):
			#anim.play("item_pop")
			#print("playing item spawn animation")
		await get_tree().create_timer(0.8).timeout
		rect.visible = false
		print("visible false for item")
		print("moving to next item")


func whiteboard_done() -> void:
	print("Bouncer idle")
	$"../../Bouncer/AnimatedSprite2D".play("idle")
	$Whiteboard.visible = false
	await get_tree().create_timer(0.5).timeout


func show_whiteboard_sequence(items:Array) -> void:
	print("Bouncer arm raise")
	$"../../Bouncer/AnimatedSprite2D".play("arm_raise")
	assign_to_whiteboard(items)
	$Whiteboard.visible = true
	await get_tree().create_timer(1).timeout
	await reveal_whiteboard_items()
	await whiteboard_done()


func get_guest_responses(items:Array, dogtype) -> Array:
	print("getting guest responses")
	dogtype = dogtype
	var result = []
	# for each item, gives response based on dogtype
	for item in items:
		var expected = expectedResponse[item]

		if dogtype == Global.DogType.REAL:
			print("guest:dogtype response real added to array")
			result.append(expected)       # REALdog gives correct answer
		else:
			print("guest:dogtype response fake added to array")
			result.append(1 - expected)   # FAKEdog gives opposite answer
	print(result)
	return result

var like_response = preload("res://assets/minigame/heart.png")
var dislike_response = preload("res://assets/minigame/redx.png")

var actual_responses = {
	like_response : 0,
	dislike_response : 1 
}

func display_guest_resp(result: Array) -> void:
	print("Displaying guest responses")
	var rects = [
		$GuestResp/Response1,
		$GuestResp/Response2,
		$GuestResp/Response3
	]
	for r in rects:
		r.visible = false

	for i in range(rects.size()):
		var value = result[i]
		# Find which image matches value
		var img 
		for key in actual_responses.keys():
			if actual_responses[key] == value:
				img = key
				break
		# Assign the correct speech bubble image
		rects[i].texture = img
		rects[i].visible = true
		play_reaction_sound(value)
		await get_tree().create_timer(0.6).timeout
		rects[i].visible = false
		await get_tree().create_timer(0.6).timeout

func play_reaction_sound(reaction) -> void:
	if reaction == 0:
		$PositiveReactionSound.play()
	else:
		$NegativeReactionSound.play()

func start_minigame(dogtype):
	Global.minigame_started.emit("reaction")
	print("Running start_reaction_test")
	$Whiteboard.visible = false
	visible = true
	dogtype = dogtype
	
	var phrase = bouncertext.pick_random()
	Global.bouncer_bubble.emit(phrase, "lower")
	
	await get_tree().create_timer(3.0).timeout
	$"../../BouncerSpeechBubble".visible = false
	
	var items = get_random_items(3)
	
	await show_whiteboard_sequence(items)
	await get_tree().create_timer(1.0).timeout
	
	guestresponse = get_guest_responses(items, dogtype)
	print(dogtype)
	await display_guest_resp(guestresponse)
	Global.set_buttons_enabled.emit(true)
	

func cleanup() -> void:
	visible = false

func _ready() -> void:
	Guest = preload("res://src/characters/guest.tscn").instantiate()
	dogtype = Guest.dogtype
	

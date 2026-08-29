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

# TO DO : - need to hold these and display corresponding images on bouncer whiteboard


func get_guest_responses(items:Array) -> Array:
	var result = []
	# for each item, gives response based on dogtype
	for item in items:
		var expected = expectedResponse[item]

		if dogtype == dogtype.REAL:
			result.append(expected)       # REALdog gives correct answer
		else:
			result.append(1 - expected)   # FAKEdog gives opposite answer

	return result

#To Do: - make response sprites
# - need to associate responses to a 
# - second dictionary with response images for guest
# - which also activates speech bubble above head

func _ready() -> void:
	Guest = preload("res://src/characters/guest.tscn").instantiate()
	dogtype = Guest.dogtype
	
	var items = get_random_items(3)
	guestresponse = get_guest_responses(items)

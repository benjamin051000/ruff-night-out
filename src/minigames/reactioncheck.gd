extends Node2D

var cellphonepic = preload("res://assets/minigame/cellphone.png")
var bonepic = preload("res://assets/minigame/bone.png")

var guestresponse 
var Guest 
var dogtype
var acceptance = true
var rejection = false

enum responses {POSITIVE, NEGATIVE}

var expectedResponse = {
	cellphonepic = 1,
	bonepic = 0}

func dog_positive(dogtype):
	if dogtype == dogtype.REAL:
		guestresponse = 0
	else:
		guestresponse = 1

func dog_neg(dogtype):
	if dogtype == dogtype.REAL:
		guestresponse = 1
	else: 
		guestresponse = 0

func response(guestresponse):
	if guestresponse != expectedResponse.value:
		return rejection
	else:
		return acceptance



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Guest = preload("res://src/characters/guest.tscn").instantiate()
	dogtype = Guest.dogtype

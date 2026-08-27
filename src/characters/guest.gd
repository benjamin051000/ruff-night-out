extends Node2D

enum DogType {REAL, FAKE}

@onready var speech_bubble: MarginContainer = $SpeechBubble
@export var dogtype: DogType
var real_or_fake
var rand_minigame
var dialogue 

func newguesttype():
		real_or_fake = randi_range(0,9) 
		if  real_or_fake in range(3,9): # 30% chance of guest being fake
			dogtype = DogType.REAL
		else:
			dogtype = DogType.FAKE


func talk(dogType):  #for initial greeting to bouncer
	const real_speech = ["I am real dog.","RealDog greeting 2", 
		"RealDog greeting 3", "RealDog greeting 4", "RealDog greeting 5"]
	const fake_speech = ["I hate pets!","NotDog greeting 2",
		"NotDog greeting 3","NotDog greeting 4", "NotDog greeting 5"]
		# if we change the amount of greeting options, 
		# need to change the ranges below as well
	if dogType == DogType.REAL:
		return speech_bubble.display_text(real_speech[(randi_range(0,4))])
	else:
		return speech_bubble.display_text(fake_speech[(randi_range(0,4))])
		


func _ready() -> void:
	newguesttype()
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
	

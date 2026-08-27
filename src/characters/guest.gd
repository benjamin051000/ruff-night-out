extends Node2D

enum DogType {REAL, FAKE}
@onready var speech_bubble: Node2D = $SpeechBubble
@export var dogtype: DogType



func _ready() -> void:
	if randi_range(0, 1) == 0:
		dogtype = DogType.REAL
	else:
		dogtype = DogType.FAKE

func talk(_prompt: String): 
	const real_speech = ["I am real dog.","RealDog greeting 2", 
		"RealDog greeting 3", "RealDog greeting 4", "RealDog greeting 5"]
	const fake_speech = ["I hate pets!","NotDog greeting 2",
		"NotDog greeting 3","NotDog greeting 4", "NotDog greeting 5"]
		
	if dogtype == DogType.REAL:
		speech_bubble.display_text(real_speech[(randi_range(0,4))])
	else:
		speech_bubble.display_text(fake_speech[(randi_range(0,4))])
		
var real_dog_names = ["Kumo", "Taro", "Marigold", "Ollie", "Lucky", "Izzy", 
	"Teddy", "Willa", "Otso", "Osho", "Tenor", "Bernie", "Cassie"]
var fake_dog_names = ["Duke Growlsworth", "Sir Woofington IV", 
	"King Barkthur of Wagsalot", "Lady Sheila Sniffums", "Barry Borkbottom", 
	"Woofred Diggysworth", "Bob Barker", "Bowow Boy", "Not A Cat", 
	"Barkley Wellington", "Trust Me, I'm A Dog"]

var id_check := preload("res://src/minigames/id_check.tscn")
var idc := id_check.instantiate()

func make_address():
	#Randomize numbers from #1–999 
	# pick a street name from a list (list needed)
	pass

func make_expiration(dob):
	#Randomize dates from 01/01/2030–12/31/2035 
	# but have the month and the day match the DoB.
	pass

func make_ID():
	# Randomize 9 digits
	pass

func make_age(dogType):
	if dogType == DogType.REAL:
		#Randomize dates from 01/01/2000 to 08/23/2025. 
		# If real, from past 8 years (2017-2025)
		pass
	else:
		#logic for fake ages, (2000-2016)
		pass

func make_name(dogtype):
	if dogtype == DogType.REAL:
		real_dog_names.shuffle()
		idc.Name.text = real_dog_names.pop_back()
		
	else:
		fake_dog_names.shuffle()
		idc.Name.text = fake_dog_names.pop_back()
		"res://assets/placeholder_real_pawprint.png"

const PLACEHOLDER_REAL_PAWPRINT = preload("uid://dlxv2ryy4auyl")
const PLACEHOLDER_FAKE_PAWPRINT = preload("uid://wqh44j6ocm3j")
								
func make_pawprint(dogtype):
	if dogtype == DogType.REAL:
		idc.Pawprint.Texture = PLACEHOLDER_REAL_PAWPRINT #placeholder
		
	else:
		idc.Pawprint.Texture = PLACEHOLDER_FAKE_PAWPRINT #placeholder

func start_id_check_minigame():
	idc.Dogtype
	idc.Name.text = make_name(dogtype)
	idc.DoB.text = make_age(dogtype)
	idc.Address.text = make_address()
	idc.Expires.text = make_expiration(idc.DoB.text)
	idc.IDnum.text = make_ID()
	idc.Pawprint.Texture = make_pawprint(dogtype)
	
	add_child(idc)
	
func check_minigame_over():
	idc.queue_free()

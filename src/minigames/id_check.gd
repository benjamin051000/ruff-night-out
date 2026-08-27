extends Node

var real_dog_names = ["Kumo", "Taro", "Marigold", "Ollie", "Lucky", "Izzy", 
	"Teddy", "Willa", "Otso", "Osho", "Tenor", "Bernie", "Cassie"]
var fake_dog_names = ["Duke Growlsworth", "Sir Woofington IV", 
	"King Barkthur of Wagsalot", "Lady Sheila Sniffums", "Barry Borkbottom", 
	"Woofred Diggysworth", "Bob Barker", "Bowow Boy", "Not A Cat", 
	"Barkley Wellington", "Trust Me, I'm A Dog"]
var street_names = []

var Guest = preload("res://src/characters/guest.tscn").instantiate()
@export var dogtype = Guest.DogType


func make_address():
	var streetnum = randi_range(100,999) 
	var streetname = street_names[(randi_range(0,10))]
	var address = streetnum + " " + streetname
	return address
	
func make_expiration(dob):
	#Randomize dates from 01/01/2030–12/31/2035 
	# but have the month and the day match the DoB.
	pass

func make_IDnum():
	const chars = "0123456789"
	var id_length := 9
	var id_string := ""

	for i in range(id_length):
		id_string += chars[randi() % chars.length()]
		
	return id_string

func make_age(dogType):
	if dogType == Guest.DogType.REAL:
		# Randomize dates from 01/01/2000 to 08/23/2025. 
		# If real, from past 8 years (2017-2025)
		pass
	else:
		#logic for fake ages, (2000-2016)
		pass

func make_name(dogtype):
	if dogtype == Guest.DogType.REAL:
		real_dog_names.shuffle()
		$Name.text = real_dog_names.pop_back()
		
	else:
		fake_dog_names.shuffle()
		$Name.text = fake_dog_names.pop_back()

const PLACEHOLDER_REAL_PAWPRINT = preload("uid://dlxv2ryy4auyl")
const PLACEHOLDER_FAKE_PAWPRINT = preload("uid://wqh44j6ocm3j")

func make_pawprint(dogtype):
	if dogtype == Guest.DogType.REAL:
		$Pawprint.Texture = PLACEHOLDER_REAL_PAWPRINT #placeholder
	else:
		$Pawprint.Texture = PLACEHOLDER_FAKE_PAWPRINT #placeholder
		
func start_id_check_minigame(dogtype):
	$Dogtype.text = dogtype
	$Name.text = make_name(dogtype)
	$DoB.text = make_age(dogtype)
	$Address.text = make_address()
	$Expires.text = make_expiration($DoB.text)
	$IDnum.text = make_IDnum()
	$Pawprint.Texture = make_pawprint(dogtype)
	
	
func check_minigame_over():
	queue_free()

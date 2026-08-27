extends Node

var real_dog_names = ["Kumo", "Taro", "Marigold", "Ollie", "Lucky", "Izzy", 
	"Teddy", "Willa", "Otso", "Osho", "Tenor", "Bernie", "Cassie"]
var fake_dog_names = ["Duke Growlsworth", "Sir Woofington IV", 
	"King Barkthur of Wagsalot", "Lady Sheila Sniffums", "Barry Borkbottom", 
	"Woofred Diggysworth", "Bob Barker", "Bowow Boy", "Not A Cat", 
	"Barkley Wellington", "Trust Me, I'm A Dog"]

var Guest = preload("uid://cub3q0665kin3")
var idc = preload("uid://cp8ahl3obc3ay")

@export var dogtype = Guest.DogType



func make_address():
	#Randomize numbers from #1–999 
	# pick a street name from a list (list needed)
	pass

func make_expiration(dob):
	#Randomize dates from 01/01/2030–12/31/2035 
	# but have the month and the day match the DoB.
	pass

func make_IDnum():
	# Randomize 9 digits
	pass

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
		idc.Name.text = real_dog_names.pop_back()
		
	else:
		fake_dog_names.shuffle()
		idc.Name.text = fake_dog_names.pop_back()

const PLACEHOLDER_REAL_PAWPRINT = preload("uid://dlxv2ryy4auyl")
const PLACEHOLDER_FAKE_PAWPRINT = preload("uid://wqh44j6ocm3j")

func make_pawprint(dogtype):
	if dogtype == Guest.DogType.REAL:
		idc.Pawprint.Texture = PLACEHOLDER_REAL_PAWPRINT #placeholder
		
	else:
		idc.Pawprint.Texture = PLACEHOLDER_FAKE_PAWPRINT #placeholder
		
func start_id_check_minigame(dogtype):
	idc.Dogtype = dogtype
	idc.Name.text = idc.make_name(dogtype)
	idc.DoB.text = idc.make_age(dogtype)
	idc.Address.text = idc.make_address()
	idc.Expires.text = idc.make_expiration(idc.DoB.text)
	idc.IDnum.text = idc.make_ID()
	idc.Pawprint.Texture = idc.make_pawprint(dogtype)
	
	add_child(idc)
	
func check_minigame_over():
	idc.queue_free()

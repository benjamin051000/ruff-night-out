extends Node2D

var real_dog_names = ["Kumo", "Taro", "Marigold", "Ollie", "Lucky", "Izzy", 
	"Teddy", "Willa", "Otso", "Osha", "Tenor", "Bernie", "Cassie", "Bruno",
	"Apple", "Utah", "Mila", "Gaga", "Zeus"]
var fake_dog_names = ["Duke Growlsworth", "Sir Woofington IV", 
	"King Barkthur", "Miss Sniffums", "Barry Borkbottom", 
	"Woofred Digsworth", "Bob Barker", "Bowow Boy", "Not A. Cat", 
	"Barkley Barkton", "Im A. Dog", "Mewsha M. Meowy", "Boof LastName"]
var street_names = ["Ray Way","Cloudy Ct.","Maisy Ln.","Ollie Blvd.",
		"Rini Rd.","Ratface Terr.","Gem Dr.","Rhyme Pl.", "Michael St."]
var Guest
var dogtype

func make_address():
	var streetnum = str(randi_range(100,999)) 
	var streetname = street_names[(randi_range(0,7))]
	var address = streetnum + " " + streetname
	return address
	
func make_expiration(dob):
	#Randomize dates from 01/01/2030–12/31/2035 
	# but have the month and the day match the DoB.
	var expir = str(randi_range(2030,2035))
	var date = dob.left(-4)
	expir = date + expir
	return expir

func make_IDnum():
	const chars = "0123456789"
	var id_length := 9
	var id_string := ""

	for i in range(id_length):
		id_string += chars[randi() % chars.length()]
		
	return id_string
	
var birthday_year = "20"

func find_year(dogtype):
	if dogtype == Global.DogType.REAL:
		birthday_year = "20" + str(randi_range(18,25))
		# If real, from past 8 years (2018-2025)
	else:
		#logic for fake ages, (2000-2010)
		var endyear = randi_range(0,10)
		if endyear <= 9:
			endyear = "0"+ str(endyear)
		else:
			pass
		birthday_year = "20" + str(endyear)
	return birthday_year

func make_age(dogtype):
	# Randomize dates from 01/01/2000 to 08/23/2025. 
	var birthday_month = str(randi_range(1,12))
	var birthday_day = str(randi_range(1,28))
	var combined
	var birthday_Year = find_year(dogtype)
	combined = (birthday_month+"/"+birthday_day+"/"+birthday_Year)
	return combined

func make_name(dogtype):
	var name
	if dogtype == Global.DogType.REAL:
		real_dog_names.shuffle()
		name = real_dog_names.pop_back()
		return name
	else:
		fake_dog_names.shuffle()
		name = fake_dog_names.pop_back()
		return name

var real_paw = [preload("res://assets/minigame/dogpaw2.png"), preload("res://assets/minigame/dogpaw.png")]
var fake_paw = [preload("res://assets/minigame/fakepaw.png"), preload("res://assets/minigame/catpaw.png")]

func make_pawprint(dogtype):
	if dogtype == Global.DogType.REAL:
		$Pawprint.texture = real_paw[randi_range(0,1)]
	else:
		$Pawprint.texture = fake_paw[randi_range(0,1)]


func start_minigame(dogtype):
	Global.minigame_started.emit("idcheck")
	visible = true
	$Dogtype.text = Global.DogType.keys()[dogtype]
	$Name.text = make_name(dogtype)
	$DoB.text = make_age(dogtype)
	$Address.text = make_address()
	$Expires.text = make_expiration($DoB.text)
	$IDnum.text = make_IDnum()
	make_pawprint(dogtype)
	Global.set_buttons_enabled.emit(true)
	
func cleanup():
	visible = false
	
func _ready() -> void:
	Guest = preload("res://src/characters/guest.tscn").instantiate()
	dogtype = Guest.dogtype
	

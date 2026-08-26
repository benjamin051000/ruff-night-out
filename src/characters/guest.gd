extends Node2D

enum DogType {REAL, FAKE}

@onready var speech_bubble: Node2D = $SpeechBubble

@export var dogtype: DogType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randi_range(0, 1) == 0:
		dogtype = DogType.REAL
	else:
		dogtype = DogType.FAKE

func talk(_prompt: String): 
	const real_speech = "I am real dog."
	const fake_speech = "I hate pets!"
	if dogtype == DogType.REAL:
		speech_bubble.display_text(real_speech)
	else:
		speech_bubble.display_text(fake_speech)

var id_check := preload("res://src/minigames/id_check.tscn")
var idc := id_check.instantiate()
func start_id_check_minigame():
	idc.Name.text = "foo"
	idc.Age.text = "123"
	add_child(idc)
	
func check_minigame_over():
	idc.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

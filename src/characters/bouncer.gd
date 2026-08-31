extends Node2D


const PIC_RESPONSE = preload("res://src/minigames/reactioncheck.tscn")
var pic_response := PIC_RESPONSE.instantiate()

var bouncer_init_phrases := [
	"Can I see some ID?",
	"bounce bounce bounce",
	"I'm gonna need to see some identification.",
	"Identification please.",
	"ID, please.",
	"I'm gonna have to see some ID.",
	"Aren't you a little young to be at the dog club?"
]

func speak() -> void:
	var phrase = bouncer_init_phrases.pick_random()
	Global.bouncer_bubble.emit(phrase, "lower")

func start_pic_response():
	pic_response.position.y -= 100
	add_child(pic_response)

func _step_helper(left: bool) -> Signal:
	var dx := -200 if left else 200
	var tween := create_tween()
	# TRANS_BACK, _QUINT look good
	tween.tween_property(self, "position:x", position.x + dx, 1).set_trans(Tween.TRANS_QUINT)
	return tween.finished


func step_back() -> Signal:
	return _step_helper(false)

func step_forward() -> Signal:
	return _step_helper(true)

func face_left() -> void:
	$AnimatedSprite2D.play("idle")
	
func face_right() -> void:
	$AnimatedSprite2D.play("right")

func idle() -> void:
	$AnimatedSprite2D.stop()

func exit_door() -> Signal:
	var old_z_index := z_index
	var old_scale := scale
	var old_modulate_a := modulate.a
	
	z_index = -9
	modulate.a = 0
	scale /= 1.2
	# TODO just set modulate.a = 0 in _ready?
	visible = true
	
	var tween := create_tween()
	#tween.tween_property(self, "position:x", door_x, 0.5)
	tween.tween_callback(func(): z_index = old_z_index)
	tween.tween_property(self, "modulate:a", old_modulate_a, 0.5)
	tween.parallel().tween_property(self, "scale", old_scale, 0.5)
	return tween.finished
	
func _ready():
	$AnimatedSprite2D.play("idle")

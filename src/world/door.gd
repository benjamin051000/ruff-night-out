extends Node2D

@onready var sprite_2d: Sprite2D = $Door
@onready var shadow: Sprite2D = $Door/Shadow

signal door_opened
signal door_closed

## open/close time
@export var t : float = 1

var music_lp_filter: AudioEffect
@export var lp_cutoff: float = 400.0

## x-val for the sprite when the door is opened
var open_x: float
## x-val for sprite when door is closed
var close_x: float

func _ready() -> void:
	music_lp_filter = AudioServer.get_bus_effect(1, 0)
	# The door is shut at first, so set the cutoff
	music_lp_filter.cutoff_hz = lp_cutoff
	
	close_x = sprite_2d.position.x
	open_x = sprite_2d.position.x - sprite_2d.texture.get_size().x

func _pos_helper(pos: float, shadow_off: float, sig: Signal) -> void:
	var pos_tween = create_tween()
	pos_tween.tween_property(sprite_2d, "position:x", pos, t).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	pos_tween.parallel().tween_property(shadow, "position:x", shadow_off, t).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	pos_tween.tween_callback(func(): sig.emit())

func _lp_helper(cutoff: float) -> void:
	var lp_tween = create_tween()
	lp_tween.tween_property(music_lp_filter, "cutoff_hz", cutoff, t).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)

func open() -> void:
	_pos_helper(open_x, close_x - open_x, door_opened)
	_lp_helper(20500)  # Max allowed
	$OpenSound.play()

func close() -> void:
	_pos_helper(close_x, 0, door_closed)
	_lp_helper(lp_cutoff)
	$CloseSound.play()

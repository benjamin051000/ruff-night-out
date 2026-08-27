extends Node2D

@onready var sprite_2d: Sprite2D = $Mask/Sprite2D

signal door_opened
signal door_closed

## open/close time
@export var t : float = 1

var tween: Tween

## x-val for the sprite when the door is opened
var open_x: float
## x-val for sprite when door is closed
var close_x: float

func _ready() -> void:
	close_x = sprite_2d.position.x
	open_x = sprite_2d.position.x - sprite_2d.texture.get_size().x

func _helper(pos: float, sig: Signal) -> void:
	tween = create_tween()
	tween.tween_property(sprite_2d, "position:x", pos, t).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	tween.tween_callback(func(): sig.emit())

func open() -> void:
	_helper(open_x, door_opened)

func close() -> void:
	_helper(close_x, door_closed)

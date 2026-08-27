extends Node2D

const Guest = preload("res://src/characters/guest.tscn")
var guests: Array

## When this hits 0, game over!
var strikes := 3

enum Minigames {PIC_RESPONSE, ID_CHECK}

@onready var bouncer: Node2D = $Bouncer
@onready var door: Node2D = $Door

func move_camera() -> void:
	var zoom_tween = create_tween()
	var pan_tween = create_tween()
	zoom_tween.tween_property($Camera2D, "zoom", Vector2(1, 1), 2)
	pan_tween.tween_property($Camera2D, "position", Vector2(1920/2, 1080/2), 2)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door.door_opened.connect(func():
		bouncer.visible = true
		door.close()
		move_camera()
	)
	door.open()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("pressed")

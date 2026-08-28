extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

const PIC_RESPONSE = preload("res://src/minigames/pic_response.tscn")
var pic_response := PIC_RESPONSE.instantiate()

func start_pic_response():
	pic_response.position.y -= 100
	add_child(pic_response)

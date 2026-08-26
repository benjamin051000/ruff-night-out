extends Node2D

const Guest = preload("res://src/characters/guest.tscn")
var guests: Array

## When this hits 0, game over!
var strikes := 3

enum Minigames {PIC_RESPONSE, ID_CHECK}
@onready var bouncer: Node2D = $Bouncer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 0:
		var g = Guest.instantiate()
		# Modify g
		g.position = Vector2(randi_range(0, 1280), randi_range(0, 720))
		add_child(g)
		guests.append(g)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("pressed")

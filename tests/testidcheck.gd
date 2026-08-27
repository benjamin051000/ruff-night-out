extends Node2D

@onready var guest: Node2D = $Guest
@onready var id_check: Node2D = $IdCheck



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id_check.start_id_check_minigame(guest.dogtype)

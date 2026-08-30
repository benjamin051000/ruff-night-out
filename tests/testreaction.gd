extends Node2D
@onready var guest: Node2D = $Guest
@onready var reaction: Node2D = $Reactioncheck
@onready var bouncer: Node2D = $Bouncer

func _ready() -> void:
	reaction.start_reaction_test(guest.dogtype)

extends Node2D
var dialogue := [
	[
		"Hey, uh, I just wanted to let you know that the last guy said you smelled a bit like updog.",
		["What's updog?", "Exactly."],  # Real
		["*Sniff, sniff* “No I don’t! >:(", "Then I s’pose you ain’t dog enough for this joint. Be seein’ ya."]  # Fake
	],
	[
		"",
		["", ""],
		["", ""]
	]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.bouncer_bubble.emit
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

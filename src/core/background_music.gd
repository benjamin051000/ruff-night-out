extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.minigame_started.connect(_on_minigame_started)

func _on_minigame_started(minigame_id) -> void:
	if minigame_id == "idcheck":
		stream.set_sync_stream_volume(1,2.5)
	else:
		stream.set_sync_stream_volume(1,-60)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

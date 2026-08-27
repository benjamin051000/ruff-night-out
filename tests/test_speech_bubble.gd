extends Node2D

const text := [
	"Hi my name is benjamin...",
	"Very nice to meet you. And your",
	"friends, who are so clearly awesome."
]

var i := 0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if i >= text.size():
			get_tree().quit()  # Not instant, so return too
			return

		$SpeechBubble.display(text[i])
		i += 1

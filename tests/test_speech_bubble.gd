extends Node2D
#
#const text := [
	#"Hi my name is benjamin.",
	#"Very nice to meet you. And your friends, who are so clearly awesome."
#]

#var i := 0

#const SpeechBubbleScene := preload("res://src/minigames/speech_bubble.tscn")

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.is_pressed():
		#if i >= text.size():
			#get_tree().quit()  # Not instant, so return too
			#return
		#
		#var sb := SpeechBubbleScene.instantiate()
		#add_child(sb)
		#sb.global_position = Vector2(1920/2, 1080/2)
		#sb.display(text[i])
		#await get_tree().create_timer(1).timeout
		#sb.queue_free()
		#i += 1
@onready var bouncer: Node2D = $Bouncer
@onready var speech_bubble: MarginContainer = $SpeechBubble

func _ready() -> void:
	Global.bouncer_bubble.connect(speech_bubble.on_bubble_display)
	for i in 5:
		print(i)
		bouncer.speak()
		await get_tree().create_timer(2).timeout

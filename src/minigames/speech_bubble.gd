# Shamelessly stolen from https://www.youtube.com/watch?v=1DRy5An_6DU
extends MarginContainer


@onready var label: Label = $MarginContainer/Label
#@onready var timer: Timer = $Timer

#const letter_time := 0.03
#const space_time := 0.06
#const punctuation_time := 0.2
@export var max_width := 128
#var text = ""
#var letter_idx = 0

enum BubbleStyle {BOUNCER, GUEST}
@export var bubble_style: BubbleStyle = BubbleStyle.BOUNCER

func _ready() -> void:
	if bubble_style == BubbleStyle.GUEST:
		$NinePatchRect.texture = preload("res://assets/px_speechbubblebig_other.png")
		label.add_theme_color_override("font_color", Color(0, 0, 0))
		

#signal finished_displaying
#
#func _on_timer_timeout() -> void:
	#_display_letter()
	
#func _display_letter() -> void:
	#label.text += text[letter_idx]
	#letter_idx += 1
	#if letter_idx >= text.length():
		#finished_displaying.emit()
		#return
	#
	#match text[letter_idx]:
		#"!", ",", ".", ":", ";", "?":
			#timer.start(punctuation_time)
		#" ":
			#timer.start(space_time)
		#_:
			#timer.start(letter_time)

func on_bubble_display(text: String) -> void:
	visible = true
	#text = text_
	label.text = text
	
	# The text Label should be (relatively) unscaled
	#label.scale = Vector2(1, 1) / scale
	
	await resized  # Wait for the container to resize itself after all text is displayed
	custom_minimum_size.x = min(size.x, max_width)
	
	if size.x > max_width:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	
	#label.text = ""
	#_display_letter()

extends Node2D

func exit_door() -> void:
	z_index = 0
	modulate.a = 0
	scale = Vector2(10, 10)
	scale /= 1.2
	visible = true
	
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)
	tween.parallel().tween_property(self, "scale", Vector2(10,10), 0.5)

func enter_door() -> void:
	#const door_x := 1600  # eyeballed
	var tween := create_tween()
	#tween.tween_property(self, "position:x", door_x, 0.5)
	z_index = -9
	#tween.tween_callback(func(): z_index = -9)
	tween.tween_property(self, "modulate:a", 0, 0.5)
	tween.parallel().tween_property(self, "scale", scale/1.2, 0.5)
	#tween.tween_callback(queue_free)

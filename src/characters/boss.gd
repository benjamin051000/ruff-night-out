extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func exit_door() -> void:
	var old_z_index := z_index
	var old_scale := scale
	var old_modulate_a := modulate.a
	
	z_index = -9
	modulate.a = 0
	scale /= 1.2
	# TODO just set modulate.a = 0 in _ready?
	visible = true
	
	var tween := create_tween()
	#tween.tween_property(self, "position:x", door_x, 0.5)
	tween.tween_callback(func(): z_index = old_z_index)
	tween.tween_property(self, "modulate:a", old_modulate_a, 0.5)
	tween.parallel().tween_property(self, "scale", old_scale, 0.5)

func enter_door() -> void:
	#const door_x := 1600  # eyeballed
	var tween := create_tween()
	#tween.tween_property(self, "position:x", door_x, 0.5)
	z_index = -9
	#tween.tween_callback(func(): z_index = -9)
	tween.tween_property(self, "modulate:a", 0, 0.5)
	tween.parallel().tween_property(self, "scale", scale/1.2, 0.5)
	#tween.tween_callback(queue_free)

extends Node2D


const PIC_RESPONSE = preload("res://src/minigames/reactioncheck.tscn")
var pic_response := PIC_RESPONSE.instantiate()

func start_pic_response():
	pic_response.position.y -= 100
	add_child(pic_response)

func _step_helper(left: bool) -> void:
	var dx := -200 if left else 200
	var tween := create_tween()
	# TRANS_BACK, _QUINT look good
	tween.tween_property(self, "position:x", position.x + dx, 1).set_trans(Tween.TRANS_QUINT)


func step_back() -> void:
	_step_helper(false)

func step_forward() -> void:
	_step_helper(true)

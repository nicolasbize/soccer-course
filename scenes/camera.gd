class_name Camera
extends Camera2D

const SMOOTHING_PLAYER := 2
const SMOOTHING_FREEFORM := 8

@export var ball : Ball
@export var distance_target : float

func _process(_delta: float) -> void:
	if ball.carrier != null:
		position = ball.carrier.position + ball.carrier.heading * distance_target
		position_smoothing_speed = SMOOTHING_PLAYER
	else:
		position = ball.position
		position_smoothing_speed = SMOOTHING_FREEFORM

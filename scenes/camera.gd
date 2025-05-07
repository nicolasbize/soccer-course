class_name Camera
extends Camera2D

const DISTANCE_TARGET := 100.0
const DURATION_SHAKE := 120.0
const SHAKE_INTENSITY := 5.0
const SMOOTHING_BALL_CARRIED := 2
const SMOOTHING_BALL_DEFAULT := 8

@export var ball : Ball

var is_shaking := false
var time_start_shaking := Time.get_ticks_msec()

func _init() -> void:
	GameEvents.impact_received.connect(on_impact_received.bind())

func _process(_delta: float) -> void:
	if ball.carrier != null:
		position = ball.carrier.position + ball.carrier.heading * DISTANCE_TARGET
		position_smoothing_speed = SMOOTHING_BALL_CARRIED
	else:
		position = ball.position
		position_smoothing_speed = SMOOTHING_BALL_DEFAULT
	
	if is_shaking and (Time.get_ticks_msec() - time_start_shaking < DURATION_SHAKE):
		offset = Vector2(randf_range(-SHAKE_INTENSITY, SHAKE_INTENSITY), randf_range(-SHAKE_INTENSITY, SHAKE_INTENSITY))
	else:
		offset = Vector2.ZERO
		is_shaking = false

func on_impact_received(_impact_position: Vector2, is_high_impact: bool) -> void:
	if is_high_impact:
		is_shaking = true
		time_start_shaking = Time.get_ticks_msec()

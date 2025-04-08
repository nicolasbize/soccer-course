class_name PlayerStateHeader
extends PlayerState

const HEIGHT_START := 0.1
const HEIGHT_VELOCITY := 2.0
const BONUS_POWER := 1.25

func _enter_tree() -> void:
	animation_player.play("header")
	player.height = HEIGHT_START
	player.height_velocity = HEIGHT_VELOCITY
	ball_detection_area.body_entered.connect(on_ball_enter.bind())

func on_ball_enter(game_ball: Ball) -> void:
	if game_ball.can_air_connect():
		game_ball.shoot(player.velocity.normalized() * player.power * BONUS_POWER)
		
func _process(_delta: float) -> void:
	if player.height == 0:
		transition_state(Player.State.RECOVERING)

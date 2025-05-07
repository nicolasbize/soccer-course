class_name GameStateInPlay
extends GameState

const DURATION_IMPACT_PAUSE = 100

var time_since_paused := Time.get_ticks_msec()

func _init() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func _enter_tree() -> void:
	GameEvents.team_scored.connect(on_team_scored.bind())
	GameEvents.impact_received.connect(on_impact_received.bind())

func _process(delta: float) -> void:
	manager.time_left -= delta
	if manager.is_time_up():
		if manager.is_game_tied():
			transition_state(GameManager.State.OVERTIME)
		else:
			transition_state(GameManager.State.GAMEOVER)
	if get_tree().paused and Time.get_ticks_msec() - time_since_paused > DURATION_IMPACT_PAUSE:
		get_tree().paused = false

func on_team_scored(country_scored_on: String) -> void:
	transition_state(GameManager.State.SCORED, GameStateData.build().set_country_scored_on(country_scored_on))

func on_impact_received(_impact_position: Vector2, is_high_impact: bool) -> void:
	if is_high_impact:
		time_since_paused = Time.get_ticks_msec()
		get_tree().paused = true

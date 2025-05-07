class_name GameStateInPlay
extends GameState

func _enter_tree() -> void:
	GameEvents.team_scored.connect(on_team_scored.bind())

func _process(delta: float) -> void:
	manager.time_left -= delta
	if manager.is_time_up():
		if manager.is_game_tied():
			transition_state(GameManager.State.OVERTIME)
		else:
			transition_state(GameManager.State.GAMEOVER)

func on_team_scored(country_scored_on: String) -> void:
	transition_state(GameManager.State.SCORED, GameStateData.build().set_country_scored_on(country_scored_on))

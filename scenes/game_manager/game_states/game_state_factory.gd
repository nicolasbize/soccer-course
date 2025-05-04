class_name GameStateFactory

var states : Dictionary

func _init() -> void:
	states = {
		GameManager.State.GAMEOVER: GameStateGameOver,
		GameManager.State.IN_PLAY: GameStateInPlay,
		GameManager.State.KICKOFF: GameStateKickoff,
		GameManager.State.OVERTIME: GameStateOvertime,
		GameManager.State.RESET: GameStateReset,
		GameManager.State.SCORED: GameStateScored,
	}

func get_fresh_state(state: GameManager.State) -> GameState:
	assert(states.has(state), "state does not exist")
	return states.get(state).new()

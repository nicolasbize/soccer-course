class_name GameStateReset
extends GameState

func _enter_tree() -> void:
	GameEvents.team_reset.emit()
	GameEvents.kickoff_ready.connect(on_kickoff_ready.bind())

func on_kickoff_ready() -> void:
	transition_state(GameManager.State.KICKOFF, state_data)

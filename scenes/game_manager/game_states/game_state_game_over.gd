class_name GameStateGameOver
extends GameState

func _enter_tree() -> void:
	var country_winner := manager.get_winner_country()
	GameEvents.game_over.emit(country_winner)

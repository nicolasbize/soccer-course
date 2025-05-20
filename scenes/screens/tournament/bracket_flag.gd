class_name BracketFlag
extends TextureRect

@onready var border : TextureRect = %Border
@onready var score_label : Label = %ScoreLabel

func set_as_current_team() -> void:
	border.visible = true

func set_as_winner(score: String) -> void:
	score_label.text = score
	score_label.visible = true

func set_as_loser() -> void:
	modulate = Color(0.2, 0.2, 0.2, 1)

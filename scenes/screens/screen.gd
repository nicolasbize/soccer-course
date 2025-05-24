class_name Screen
extends Node

signal screen_transition_requested(new_screen: SoccerGame.ScreenType, data: ScreenData)

@export var music: MusicPlayer.Music

var game : SoccerGame = null
var screen_data : ScreenData = null

func _enter_tree() -> void:
	MusicPlayer.play_music(music)

func setup(context_game: SoccerGame, context_data: ScreenData) -> void:
	game = context_game
	screen_data = context_data

func transition_screen(new_screen: SoccerGame.ScreenType, data: ScreenData = ScreenData.new()) -> void:
	screen_transition_requested.emit(new_screen, data)

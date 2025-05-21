class_name TournamentScreen
extends Screen

const STAGE_TEXTURES := {
	Tournament.Stage.QUARTER_FINALS: preload("res://assets/art/ui/teamselection/quarters-label.png"),
	Tournament.Stage.SEMI_FINALS: preload("res://assets/art/ui/teamselection/semis-label.png"),
	Tournament.Stage.FINAL: preload("res://assets/art/ui/teamselection/finals-label.png"),
	Tournament.Stage.COMPLETE: preload("res://assets/art/ui/teamselection/winner-label.png"),
}

@onready var flag_containers : Dictionary = {
	Tournament.Stage.QUARTER_FINALS: [%QFLeftContainer, %QFRightContainer],
	Tournament.Stage.SEMI_FINALS: [%SFLeftContainer, %SFRightContainer],
	Tournament.Stage.FINAL: [%FinalLeftContainer, %FinalRightContainer],
	Tournament.Stage.COMPLETE: [%WinnerContainer],
}
@onready var stage_texture : TextureRect = %StageTexture

var player_country : String = GameManager.player_setup[0]
var tournament : Tournament = null

func _ready() -> void:
	tournament = screen_data.tournament
	refresh_brackets()

func _process(_delta: float) -> void:
	if KeyUtils.is_action_just_pressed(Player.ControlScheme.P1, KeyUtils.Action.SHOOT):
		if tournament.current_stage < Tournament.Stage.COMPLETE:
			transition_screen(SoccerGame.ScreenType.IN_GAME, screen_data)
		else:
			transition_screen(SoccerGame.ScreenType.MAIN_MENU)
		SoundPlayer.play(SoundPlayer.Sound.UI_SELECT)

func refresh_brackets() -> void:
	for stage in range(tournament.current_stage + 1):
		refresh_bracket_stage(stage)

func refresh_bracket_stage(stage: Tournament.Stage) -> void:
	var flag_nodes := get_flag_nodes_for_stage(stage)
	stage_texture.texture = STAGE_TEXTURES.get(stage)
	if stage < Tournament.Stage.COMPLETE:
		var matches : Array = tournament.matches[stage]
		assert(flag_nodes.size() == 2 * matches.size())
		for i in range(matches.size()):
			var current_match : Match = matches[i]
			var flag_home : BracketFlag = flag_nodes[i * 2]
			var flag_away : BracketFlag = flag_nodes[i * 2 + 1]
			flag_home.texture = FlagHelper.get_texture(current_match.country_home)
			flag_away.texture = FlagHelper.get_texture(current_match.country_away)
			if not current_match.winner.is_empty():
				var flag_winner := flag_home if current_match.winner == current_match.country_home else flag_away
				var flag_loser := flag_home if flag_winner == flag_away else flag_away
				flag_winner.set_as_winner(current_match.final_score)
				flag_loser.set_as_loser()
			elif [current_match.country_home, current_match.country_away].has(player_country) and stage == tournament.current_stage:
				var flag_player := flag_home if current_match.country_home == player_country else flag_away
				flag_player.set_as_current_team()
				GameManager.current_match = current_match
	else:
		flag_nodes[0].texture = FlagHelper.get_texture(tournament.winner)

func get_flag_nodes_for_stage(stage: Tournament.Stage) -> Array[BracketFlag]:
	var flag_nodes : Array[BracketFlag] = []
	for container in flag_containers.get(stage):
		for node in container.get_children():
			if node is BracketFlag:
				flag_nodes.append(node)
	return flag_nodes

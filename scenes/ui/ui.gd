class_name UI
extends CanvasLayer

@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var flag_textures : Array[TextureRect] = [%HomeFlagTexture, %AwayFlagTexture]
@onready var goal_scorer_label : Label = %GoalScorerLabel
@onready var player_label : Label = %PlayerLabel
@onready var score_info_label : Label = %ScoreInfoLabel
@onready var score_label : Label = %ScoreLabel
@onready var time_label : Label = %TimeLabel

var last_ball_carrier := ""

func _ready() -> void:
	update_score()
	update_flags()
	update_clock()
	player_label.text = ""
	GameEvents.ball_possessed.connect(on_ball_possessed.bind())
	GameEvents.ball_released.connect(on_ball_released.bind())
	GameEvents.score_changed.connect(on_score_changed.bind())
	GameEvents.team_reset.connect(on_team_reset.bind())
	GameEvents.game_over.connect(on_game_over.bind())

func _process(_delta: float) -> void:
	update_clock()

func update_score() -> void:
	score_label.text = ScoreHelper.get_score_text(GameManager.score)

func update_flags() -> void:
	for i in flag_textures.size():
		flag_textures[i].texture = FlagHelper.get_texture(GameManager.countries[i])

func update_clock() -> void:
	if GameManager.time_left < 0:
		time_label.modulate = Color.YELLOW
	time_label.text = TimeHelper.get_time_text(GameManager.time_left)
	
func on_ball_possessed(player_name: String) -> void:
	player_label.text = player_name
	last_ball_carrier = player_name

func on_ball_released() -> void:
	player_label.text = ""

func on_score_changed() -> void:
	if not GameManager.is_time_up():
		goal_scorer_label.text = "%s SCORED!" % [last_ball_carrier]
		score_info_label.text = ScoreHelper.get_current_score_info(GameManager.countries, GameManager.score)
		animation_player.play("goal_appear")
	update_score()

func on_team_reset() -> void:
	if GameManager.has_someone_scored():
		animation_player.play("goal_hide")

func on_game_over(_country_winner: String) -> void:
	score_info_label.text = ScoreHelper.get_final_score_info(GameManager.countries, GameManager.score)
	animation_player.play("game_over")

class_name Match

var country_home : String
var country_away : String
var goals_home : int
var goals_away : int
var final_score : String
var winner : String

func _init(team_home: String, team_away: String) -> void:
	country_home = team_home
	country_away = team_away

func is_tied() -> bool:
	return goals_home == goals_away

func has_someone_scored() -> bool:
	return goals_home > 0 or goals_away > 0

func increase_score(country_scored_on: String) -> void:
	if country_scored_on == country_home:
		goals_away += 1
	else:
		goals_home += 1
	update_match_info()

func update_match_info() -> void:
	winner = country_home if goals_home > goals_away else country_away
	final_score = "%d - %d" % [max(goals_home, goals_away), min(goals_home, goals_away)]

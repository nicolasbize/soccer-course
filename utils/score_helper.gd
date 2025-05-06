class_name ScoreHelper

static func get_score_text(score: Array[int]) -> String:
	return "%d - %d" % [score[0], score[1]]

static func get_current_score_info(countries: Array[String], score: Array[int]) -> String:
	if score[0] == score[1]:
		return "TEAMS ARE TIED %d - %d" % [score[0], score[1]]
	elif score[0] > score[1]:
		return "%s LEADS %d - %d" % [countries[0], score[0], score[1]]
	else:
		return "%s LEADS %d - %d" % [countries[1], score[1], score[0]]

static func get_final_score_info(countries: Array[String], score: Array[int]) -> String:
	if score[0] > score[1]:
		return "%s WINS %d - %d" % [countries[0], score[0], score[1]]
	else:
		return "%s WINS %d - %d" % [countries[1], score[1], score[0]]

class_name Tournament

enum Stage {QUARTER_FINALS, SEMI_FINALS, FINAL, COMPLETE}

var current_stage : Stage = Stage.QUARTER_FINALS
var matches := {
	Stage.QUARTER_FINALS: [],
	Stage.SEMI_FINALS: [],
	Stage.FINAL: [],
}
var winner := ""

func _init() -> void:
	var countries := DataLoader.get_countries().slice(1, 9)
	countries.shuffle()
	create_bracket(Stage.QUARTER_FINALS, countries)
	
func create_bracket(stage: Stage, countries: Array[String]) -> void:
	for i in range(int(countries.size() / 2.0)):
		matches[stage].append(Match.new(countries[i * 2], countries[i * 2 + 1]))

func advance() -> void:
	if current_stage < Stage.COMPLETE:
		var stage_matches : Array = matches[current_stage]
		var stage_winners : Array[String] = []
		for current_match : Match in stage_matches:
			current_match.resolve()
			stage_winners.append(current_match.winner)
		current_stage = current_stage + 1 as Stage
		if current_stage == Stage.COMPLETE:
			winner = stage_winners[0]
		else:
			create_bracket(current_stage, stage_winners)

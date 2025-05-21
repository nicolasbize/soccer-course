class_name ScreenData

var tournament : Tournament = null

static func build() -> ScreenData:
	return ScreenData.new()

func set_tournament(context_tournament: Tournament) -> ScreenData:
	tournament = context_tournament
	return self

class_name GameStateData

var country_scored_on : String

static func build() -> GameStateData:
	return GameStateData.new()

func set_country_scored_on(country: String) -> GameStateData:
	country_scored_on = country
	return self

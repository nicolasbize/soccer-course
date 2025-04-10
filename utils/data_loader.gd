extends Node

const FLAG_PATH_PREFIX := "res://assets/art/ui/flags/flag-"
const SQUAD_SIZE := 6

var flags : Dictionary[String, Texture2D]
var squads : Dictionary[String, Array]

func _init() -> void:
	var json_file := FileAccess.open("res://assets/json/squads.json", FileAccess.READ)
	if json_file == null:
		printerr("could not find or load squads.json")
	var json := JSON.new()
	if json.parse(json_file.get_as_text()) != OK:
		printerr("squads.json not well formatted")
	for squad in json.data:
		var country_name := squad["country"] as String
		if not flags.has(country_name):
			var flag_fullpath := "%s%s.png" % [FLAG_PATH_PREFIX, country_name.to_lower()]
			if not FileAccess.file_exists(flag_fullpath):
				printerr("flag texture not found for country " + country_name)
			flags.set(country_name, load(flag_fullpath))
		if not squads.has(country_name):
			squads.set(country_name, [])
		var players : Array = squad["players"]
		for player in players:
			var fullname := player["name"] as String
			var skin := player["skin"] as Player.SkinColor
			var role := player["role"] as Player.Role
			var speed := player["speed"] as float
			var power := player["power"] as float
			var player_resource = PlayerResource.new(fullname, skin, role, speed, power)
			squads.get(country_name).append(player_resource)
		if players.size() != SQUAD_SIZE:
			printerr("not enough players found in squad " + country_name)
	json_file.close()

func get_squad(country: String) -> Array:
	if squads.has(country):
		return squads.get(country)
	return []

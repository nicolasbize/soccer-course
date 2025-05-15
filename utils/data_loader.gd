extends Node

var countries : Array[String] = ["DEFAULT"]
var squads : Dictionary[String, Array]

func _init() -> void:
	var json_file := FileAccess.open("res://assets/json/squads.json", FileAccess.READ)
	if json_file == null:
		printerr("could not find or load squads.json")
	var json_text := json_file.get_as_text()
	var json := JSON.new()
	if json.parse(json_text) != OK:
		printerr("could not parse squads.json")
	for team in json.data:
		var country_name := team["country"] as String
		countries.append(country_name)
		var players := team["players"] as Array
		if not squads.has(country_name):
			squads.set(country_name, [])
		for player in players:
			var fullname := player["name"] as String
			var skin := player["skin"] as Player.SkinColor
			var role := player["role"] as Player.Role
			var speed := player["speed"] as float
			var power := player["power"] as float
			var player_resource := PlayerResource.new(fullname, skin, role, speed, power)
			squads.get(country_name).append(player_resource)
		assert(players.size() == 6)
	json_file.close()
	
func get_squad(country: String) -> Array:
	if squads.has(country):
		return squads[country]
	return []

func get_countries() -> Array[String]:
	return countries

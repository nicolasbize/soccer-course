class_name FlagHelper

static var flag_textures : Dictionary[String, Texture2D] = {}

static func get_texture(country: String) -> Texture2D:
	if not flag_textures.has(country):
		flag_textures.set(country, load("res://assets/art/ui/flags/flag-%s.png" % [country.to_lower()]))
	return flag_textures[country]

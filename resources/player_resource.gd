class_name PlayerResource
extends Resource

@export var full_name : String
@export var skin_color : Player.SkinColor
@export var role : Player.Role
@export var speed : float
@export var power : float

func _init(player_name: String, player_skin: Player.SkinColor, player_role: Player.Role, player_speed: float, player_power: float) -> void:
	full_name = player_name
	skin_color = player_skin
	role = player_role
	speed = player_speed
	power = player_power

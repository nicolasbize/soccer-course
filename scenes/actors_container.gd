class_name ActorsContainer
extends Node2D

const DURATION_WEIGHT_CACHE := 200
const PLAYER_PREFAB := preload("res://scenes/characters/player.tscn")

@export var ball : Ball
@export var goal_home : Goal
@export var goal_away : Goal
@export var team_home : String
@export var team_away : String

@onready var spawns : Node2D = %Spawns

var squad_home : Array[Player] = []
var squad_away : Array[Player] = []
var time_since_last_cache_refresh := Time.get_ticks_msec()

func _ready() -> void:
	squad_home = spawn_players(team_home, goal_home)
	spawns.scale.x = -1
	squad_away = spawn_players(team_away, goal_away)
	
	var player : Player = get_children().filter(func(p): return p is Player)[4]
	player.control_scheme = Player.ControlScheme.P1
	player.set_control_texture()

func _process(_delta: float) -> void:
	if Time.get_ticks_msec() - time_since_last_cache_refresh > DURATION_WEIGHT_CACHE:
		time_since_last_cache_refresh = Time.get_ticks_msec()
		set_on_duty_weights()

func spawn_players(country: String, own_goal: Goal) -> Array[Player]:
	var player_nodes : Array[Player] = []
	var players := DataLoader.get_squad(country)
	var target_goal := goal_home if own_goal == goal_away else goal_away
	for i in players.size():
		var player_position := spawns.get_child(i).global_position as Vector2
		var player_data := players[i] as PlayerResource
		var player := spawn_player(player_position, own_goal, target_goal, player_data, country)
		player_nodes.append(player)
		add_child(player)
	return player_nodes

func spawn_player(player_position: Vector2, own_goal: Goal, target_goal: Goal, player_data: PlayerResource, country: String) -> Player:
	var player : Player = PLAYER_PREFAB.instantiate()
	player.initialize(player_position, ball, own_goal, target_goal, player_data, country)
	player.swap_requested.connect(on_player_swap_request.bind())
	return player

func set_on_duty_weights() -> void:
	for squad in [squad_away, squad_home]:
		var cpu_players : Array[Player] = squad.filter(
			func(p: Player): return p.control_scheme == Player.ControlScheme.CPU and p.role != Player.Role.GOALIE
		)
		cpu_players.sort_custom(func(p1: Player, p2: Player):
			return p1.spawn_position.distance_squared_to(ball.position) < p2.spawn_position.distance_squared_to(ball.position))

		for i in range(cpu_players.size()):
			cpu_players[i].weight_on_duty_steering = 1 - ease(float(i)/10.0, 0.1)
	
func on_player_swap_request(requester: Player) -> void:
	var squad := squad_home if requester.country == squad_home[0].country else squad_away
	var cpu_players : Array[Player] = squad.filter(
		func(p: Player): return p.control_scheme == Player.ControlScheme.CPU and p.role != Player.Role.GOALIE
	)		
	cpu_players.sort_custom(func(p1: Player, p2: Player):
		return p1.position.distance_squared_to(ball.position) < p2.position.distance_squared_to(ball.position))
	var closest_cpu_to_ball : Player = cpu_players[0]
	if closest_cpu_to_ball.position.distance_squared_to(ball.position) < requester.position.distance_squared_to(ball.position):
		var player_control_scheme := requester.control_scheme
		requester.control_scheme = Player.ControlScheme.CPU
		requester.set_control_texture()
		closest_cpu_to_ball.control_scheme = player_control_scheme
		closest_cpu_to_ball.set_control_texture()
	

extends Node

enum Sound {BOUNCE, HURT, PASS, POWERSHOT, SHOT, TACKLING, UI_NAV, UI_SELECT, WHISTLE}

const DELAY_BETWEEN_SIMILAR_SOUNDS := 100
const NB_CHANNELS := 4
const SFX_MAP : Dictionary[Sound, AudioStream] = {
	Sound.BOUNCE: preload("res://assets/sfx/bounce.wav"),
	Sound.HURT: preload("res://assets/sfx/hurt.wav"),
	Sound.PASS: preload("res://assets/sfx/pass.wav"),
	Sound.POWERSHOT: preload("res://assets/sfx/power-shot.wav"),
	Sound.SHOT: preload("res://assets/sfx/shoot.wav"),
	Sound.TACKLING: preload("res://assets/sfx/tackle.wav"),
	Sound.UI_NAV: preload("res://assets/sfx/ui-navigate.wav"),
	Sound.UI_SELECT: preload("res://assets/sfx/ui-select.wav"),
	Sound.WHISTLE: preload("res://assets/sfx/whistle.wav"),
}

var stream_players : Array[AudioStreamPlayer] = []
var time_since_played : Dictionary[Sound, int] = {}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in range(NB_CHANNELS):
		var stream_player := AudioStreamPlayer.new()
		stream_players.append(stream_player)
		add_child(stream_player)
	for i in range(Sound.size()):
		time_since_played.set(i as Sound, Time.get_ticks_msec())

func play(sound: Sound) -> void:
	if Time.get_ticks_msec() - time_since_played.get(sound) < DELAY_BETWEEN_SIMILAR_SOUNDS:
		return
	var stream_player := find_first_available_player()
	if stream_player != null:
		time_since_played.set(sound, Time.get_ticks_msec())
		stream_player.stream = SFX_MAP[sound]
		stream_player.play()
	
func find_first_available_player() -> AudioStreamPlayer:
	for stream_player in stream_players:
		if not stream_player.playing:
			return stream_player
	return null

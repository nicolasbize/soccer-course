extends AudioStreamPlayer

enum Music {NONE, GAMEPLAY, MENU, TOURNAMENT, WIN}

const MUSIC_MAP : Dictionary[Music, AudioStream] = {
	Music.GAMEPLAY: preload("res://assets/music/gameplay.mp3"),
	Music.MENU: preload("res://assets/music/menu.mp3"),
	Music.TOURNAMENT: preload("res://assets/music/tournament.mp3"),
	Music.WIN: preload("res://assets/music/win.mp3"),
}

var current_music := Music.NONE

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func play_music(music: Music) -> void:
	if music != current_music and MUSIC_MAP.has(music):
		stream = MUSIC_MAP.get(music)
		current_music = music
		play()

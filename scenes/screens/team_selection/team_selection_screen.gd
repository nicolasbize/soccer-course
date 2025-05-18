class_name TeamSelectionScreen
extends Control

const FLAG_ANCHOR_POINT := Vector2(35, 80)
const FLAG_SELECTOR_PREFAB := preload("res://scenes/screens/team_selection/flag_selector.tscn")
const NB_COLS := 4
const NB_ROWS := 2

@onready var flags_container : Control = %FlagsContainer

var move_dirs : Dictionary[KeyUtils.Action, Vector2i] = {
	KeyUtils.Action.UP: Vector2i.UP,
	KeyUtils.Action.DOWN: Vector2i.DOWN,
	KeyUtils.Action.LEFT: Vector2i.LEFT,
	KeyUtils.Action.RIGHT: Vector2i.RIGHT,
}
var selection : Array[Vector2i] = [Vector2i.ZERO, Vector2i.ZERO]
var selectors : Array[FlagSelector] = []

func _ready() -> void:
	place_flags()
	place_selectors()

func _process(_delta: float) -> void:
	for i in range(selectors.size()):
		var selector := selectors[i]
		if not selector.is_selected:
			for action : KeyUtils.Action in move_dirs.keys():
				if KeyUtils.is_action_just_pressed(selector.control_scheme, action):
					try_navigate(i, move_dirs[action])

func try_navigate(selector_index: int, direction: Vector2i) -> void:
	var rect : Rect2i = Rect2i(0, 0, NB_COLS, NB_ROWS)
	if rect.has_point(selection[selector_index] + direction):
		selection[selector_index] += direction
		var flag_index := selection[selector_index].x + selection[selector_index].y * NB_COLS
		selectors[selector_index].position = flags_container.get_child(flag_index).position
		SoundPlayer.play(SoundPlayer.Sound.UI_NAV)

func place_flags() -> void:
	for j in range(NB_ROWS):
		for i in range(NB_COLS):
			var flag_texture := TextureRect.new()
			flag_texture.position = FLAG_ANCHOR_POINT + Vector2(55 * i, 50 * j)
			var country_index := 1 + i + j * NB_COLS
			var country := DataLoader.get_countries()[country_index]
			flag_texture.texture = FlagHelper.get_texture(country)
			flag_texture.scale = Vector2(2, 2)
			flag_texture.z_index = 1
			flags_container.add_child(flag_texture)
			
func place_selectors() -> void:
	add_selector(Player.ControlScheme.P1)
	if not GameManager.player_setup[1].is_empty():
		add_selector(Player.ControlScheme.P2)
	
func add_selector(control_scheme: Player.ControlScheme) -> void:
	var selector := FLAG_SELECTOR_PREFAB.instantiate()
	selector.position = flags_container.get_child(0).position
	selector.control_scheme = control_scheme
	selectors.append(selector)
	flags_container.add_child(selector)

class_name FlagSelector
extends Control

signal selected

@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var indicator_1p : TextureRect = %Indicator1P
@onready var indicator_2p : TextureRect = %Indicator2P

var control_scheme := Player.ControlScheme.P1
var is_selected := false

func _ready() -> void:
	indicator_1p.visible = control_scheme == Player.ControlScheme.P1
	indicator_2p.visible = control_scheme == Player.ControlScheme.P2

func _process(_delta: float) -> void:
	if not is_selected and KeyUtils.is_action_just_pressed(control_scheme, KeyUtils.Action.SHOOT):
		is_selected = true
		animation_player.play("selected")
		SoundPlayer.play(SoundPlayer.Sound.UI_SELECT)
		selected.emit()
	elif is_selected and KeyUtils.is_action_just_pressed(control_scheme, KeyUtils.Action.PASS):
		is_selected = false
		animation_player.play("selecting")

class_name PlayerStateFactory

var states : Dictionary

func _init() -> void:
	states = {
		Player.State.BICYCLE_KICK: PlayerStateBicycleKick,
		Player.State.CELEBRATING: PlayerStateCelebrating,
		Player.State.CHEST_CONTROL: PlayerStateChestControl,
		Player.State.DIVING: PlayerStateDiving,
		Player.State.HURT: PlayerStateHurt,
		Player.State.HEADER: PlayerStateHeader,
		Player.State.MOURNING: PlayerStateMourning,
		Player.State.MOVING: PlayerStateMoving,
		Player.State.PASSING: PlayerStatePassing,
		Player.State.PREPPING_SHOT: PlayerStatePreppingShot,
		Player.State.RESETING: PlayerStateReseting,
		Player.State.RECOVERING: PlayerStateRecovering,
		Player.State.SHOOTING: PlayerStateShooting,
		Player.State.TACKLING: PlayerStateTackling,
		Player.State.VOLLEY_KICK: PlayerStateVolleyKick,
	}

func get_fresh_state(state: Player.State) -> PlayerState:
	assert(states.has(state), "state doesn't exist!")
	return states.get(state).new()

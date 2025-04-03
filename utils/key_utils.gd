extends Node

## Enum defining possible player actions.
enum Action {LEFT, RIGHT, UP, DOWN, SHOOT, PASS}

## Dictionary mapping control schemes to their input action names.
const ACTIONS_MAP : Dictionary = {
    Player.ControlScheme.P1: {
        Action.LEFT: "p1_left",
        Action.RIGHT: "p1_right",
        Action.UP: "p1_up",
        Action.DOWN: "p1_down",
        Action.SHOOT: "p1_shoot",
        Action.PASS: "p1_pass",
    },
    Player.ControlScheme.P2: {
        Action.LEFT: "p2_left",
        Action.RIGHT: "p2_right",
        Action.UP: "p2_up",
        Action.DOWN: "p2_down",
        Action.SHOOT: "p2_shoot",
        Action.PASS: "p2_pass",
    },
}

## Returns the input vector for the given control scheme.
## @param scheme The control scheme to use (e.g., Player.ControlScheme.P1).
## @param dead_zone The dead zone to apply to the input vector (default: 0.0).
## @return The input vector based on the movement actions.
static func get_input_vector(scheme: Player.ControlScheme, dead_zone: float = 0.0) -> Vector2:
    if not ACTIONS_MAP.has(scheme):
        push_error("Invalid control scheme: " + str(scheme))
        return Vector2.ZERO
    var map : Dictionary = ACTIONS_MAP[scheme]
    return Input.get_vector(map[Action.LEFT], map[Action.RIGHT], map[Action.UP], map[Action.DOWN], dead_zone)

## Checks if the specified action is currently pressed.
## @param scheme The control scheme to check.
## @param action The action to check (e.g., Action.SHOOT).
## @return True if the action is pressed, false otherwise.
static func is_action_pressed(scheme: Player.ControlScheme, action: Action) -> bool:
    if not ACTIONS_MAP.has(scheme):
        push_error("Invalid control scheme: " + str(scheme))
        return false
    return Input.is_action_pressed(ACTIONS_MAP[scheme][action])

## Checks if the specified action was just pressed.
## @param scheme The control scheme to check.
## @param action The action to check.
## @return True if the action was just pressed, false otherwise.
static func is_action_just_pressed(scheme: Player.ControlScheme, action: Action) -> bool:
    if not ACTIONS_MAP.has(scheme):
        push_error("Invalid control scheme: " + str(scheme))
        return false
    return Input.is_action_just_pressed(ACTIONS_MAP[scheme][action])

## Checks if the specified action was just released.
## @param scheme The control scheme to check.
## @param action The action to check.
## @return True if the action was just released, false otherwise.
static func is_action_just_released(scheme: Player.ControlScheme, action: Action) -> bool:
    if not ACTIONS_MAP.has(scheme):
        push_error("Invalid control scheme: " + str(scheme))
        return false
    return Input.is_action_just_released(ACTIONS_MAP[scheme][action])

## Checks if the player is attempting to move.
## @param scheme The control scheme to check.
## @param dead_zone The dead zone to apply (default: 0.0).
## @return True if any movement input is detected, false otherwise.
static func is_moving(scheme: Player.ControlScheme, dead_zone: float = 0.0) -> bool:
    return get_input_vector(scheme, dead_zone) != Vector2.ZERO

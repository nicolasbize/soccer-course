# In a player script
func _process(delta):
    var movement = InputHandler.get_input_vector(Player.ControlScheme.P1, 0.2)  # Use a 0.2 dead zone
    if InputHandler.is_moving(Player.ControlScheme.P1, 0.2):
        print("Player 1 is moving!")
    if InputHandler.is_action_just_pressed(Player.ControlScheme.P1, Action.SHOOT):
        print("Player 1 shot!")

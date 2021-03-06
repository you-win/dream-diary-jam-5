extends FSMState

###############################################################################
# Builtin functions                                                           #
###############################################################################

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func on_enter() -> void:
	obj.current_animation = "Idle"
	obj.anim_player.play(obj.current_animation)

func run(delta: float) -> void:
	if (obj.intended_velocity.x != 0 or obj.intended_velocity.z != 0):
		fsm.switch_state_now(delta, fsm.states.Move)
		return

	if obj.intended_velocity.y > 0:
		fsm.switch_state_now(delta, fsm.states.Jump)
		return

func on_exit() -> void:
	pass

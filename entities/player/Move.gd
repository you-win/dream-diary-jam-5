extends FSMState

const QUARTER_ROTATION: float = (PI / 2)

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
	obj.current_animation = "Move"
	obj.anim_player.play(obj.current_animation)

func run(delta: float) -> void:
	# Check for jump input
	if obj.intended_velocity.y > 0:
		fsm.switch_state_now(delta, fsm.states.Jump)
		return
	
	if (obj.intended_velocity.x != 0 or obj.intended_velocity.z != 0):
		var h_movement: Vector2 = Vector2(obj.intended_velocity.x, obj.intended_velocity.z)
		obj.skeleton.rotation.z = (atan2(h_movement.y, h_movement.x) - QUARTER_ROTATION) - obj.camera_mount.rotation.y
		h_movement = h_movement.rotated(-obj.camera_mount.rotation.y).normalized() * obj.SPEED * delta
		obj.intended_velocity = Vector3(h_movement.x, obj.intended_velocity.y, h_movement.y)

	# TODO included because I ran out of time for level design
	# so instead go fast
	if Input.is_action_pressed("sprint"):
		obj.intended_velocity.x *= obj.SPRINT_MULTIPLIER
		obj.intended_velocity.z *= obj.SPRINT_MULTIPLIER
	
	# obj.current_velocity = obj.move_and_slide(obj.intended_velocity, Vector3.UP)
	obj.current_velocity = obj.move_and_slide_with_snap(obj.intended_velocity, Vector3.DOWN, Vector3.UP, true)
	
	if (obj.current_velocity.x > 0.1 or obj.current_velocity.x < -0.1 or
			obj.current_velocity.z > 0.1 or obj.current_velocity.z < -0.1):
		obj.step_sounds.play_step_sound()

	# Switch to idle if we slow down enough
	if (not obj.current_velocity.length() > 0.1 and not obj.current_velocity.length() < - 0.1):
		fsm.switch_state_deferred(fsm.states.Idle)

func on_exit() -> void:
	pass

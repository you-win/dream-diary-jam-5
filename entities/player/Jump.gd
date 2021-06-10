extends FSMState

const QUARTER_ROTATION: float = (PI / 2)

var remaining_jump_time: float

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
	# TODO make a jumping animation
	obj.current_animation = "Idle"
	obj.anim_player.play(obj.current_animation)

	remaining_jump_time = obj.JUMP_TIME

func run(delta: float) -> void:
	var y_vel: float = 0.0
	if remaining_jump_time > 0:
		remaining_jump_time -= delta
		y_vel = obj.JUMP * delta * (1 - remaining_jump_time)
	else:
		y_vel = obj.GRAVITY * delta

	if (obj.intended_velocity.x != 0 or obj.intended_velocity.z != 0):
		var h_movement: Vector2 = Vector2(obj.intended_velocity.x, obj.intended_velocity.z)
		obj.skeleton.rotation.z = (atan2(h_movement.y, h_movement.x) - QUARTER_ROTATION) - obj.camera_mount.rotation.y
		h_movement = h_movement.rotated(-obj.camera_mount.rotation.y).normalized() * obj.SPEED * delta
		obj.intended_velocity = Vector3(h_movement.x, y_vel, h_movement.y)
	else:
		obj.intended_velocity = Vector3(0, y_vel, 0)

	obj.current_velocity = obj.move_and_slide(obj.intended_velocity, Vector3.UP)

	if obj.is_on_floor():
		fsm.switch_state_deferred(fsm.states.Idle)

func on_exit() -> void:
	pass

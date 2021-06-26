extends FSMState

const QUARTER_ROTATION: float = (PI / 2)

var y_velocity: float
var air_time: float

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

	air_time = 0.0

func run(delta: float) -> void:
	y_velocity = 0.0

	air_time += delta * 2.5
	
	y_velocity = (obj.JUMP * delta) + (obj.GRAVITY * delta * air_time)
	y_velocity = max(y_velocity, obj.MAX_FALL_SPEED)

	if (obj.intended_velocity.x != 0 or obj.intended_velocity.z != 0):
		var h_movement: Vector2 = Vector2(obj.intended_velocity.x, obj.intended_velocity.z)
		obj.skeleton.rotation.z = (atan2(h_movement.y, h_movement.x) - QUARTER_ROTATION) - obj.camera_mount.rotation.y
		h_movement = h_movement.rotated(-obj.camera_mount.rotation.y).normalized() * obj.SPEED * delta
		obj.intended_velocity = Vector3(h_movement.x, y_velocity, h_movement.y)
	else:
		obj.intended_velocity = Vector3(0, y_velocity, 0)

	obj.current_velocity = obj.move_and_slide(obj.intended_velocity, Vector3.UP)

	if obj.is_on_floor():
		fsm.switch_state_deferred(fsm.states.Idle)

func on_exit() -> void:
	pass

extends FSMState

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _init() -> void:
	self.name = "Move"

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

func run(_delta: float) -> void:
	if (obj.intended_velocity.x != 0 or obj.intended_velocity.z != 0):
		var z_rotation: float = atan2(obj.intended_velocity.z, obj.intended_velocity.x) - (PI / 2)
		obj.skeleton.rotation.z = z_rotation - obj.camera_mount.rotation.y
		obj.intended_velocity = obj.intended_velocity.rotated(Vector3.UP, obj.camera_mount.rotation.y)
		obj.current_velocity = obj.intended_velocity

	obj.current_velocity = obj.move_and_slide(obj.intended_velocity)

	if (not obj.current_velocity.length() > 0.1 and not obj.current_velocity.length() < - 0.1):
		fsm.switch_state_deferred(fsm.states.Idle)

func on_exit() -> void:
	pass

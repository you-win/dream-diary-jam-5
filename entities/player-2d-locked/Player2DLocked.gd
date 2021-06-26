class_name Player2DLocked
extends KinematicBody

const ROTATION_EIGTH: float = PI / 4
const ROTATION_FULL: float = 2 * PI

const FRICTION: float = 0.1
const SPEED: float = 250.0
const JUMP: float = 650.0
const MAX_FALL_SPEED: float = -10.0

const GRAVITY: float = -600.0

onready var skeleton: Skeleton = $Skeleton

onready var anim_player: AnimationPlayer = $AnimationPlayer
var current_animation: String = "Idle"
var next_animation: String = "Idle"

var intended_velocity: Vector3 = Vector3.ZERO
var current_velocity: Vector3 = Vector3.ZERO

var fsm: FSM

onready var camera_mount: Spatial = $CameraMount
var current_camera_rotation: float = 0.0

onready var step_sounds: Node = $StepSounds

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	anim_player.play(current_animation)

	_construct_fsm_states()

func _physics_process(delta: float) -> void:
	# Movement
	intended_velocity = Vector3.ZERO
	
	# Player input
	if Input.is_action_pressed("move_up"):
		intended_velocity.z += 1
	if Input.is_action_pressed("move_down"):
		intended_velocity.z -= 1
	if Input.is_action_pressed("move_left"):
		intended_velocity.x += 1
	if Input.is_action_pressed("move_right"):
		intended_velocity.x -= 1
	
	if Input.is_action_just_pressed("jump"):
		intended_velocity.y += 1
	else:
		# Gravity
		intended_velocity.y += GRAVITY * delta

	fsm.run(delta)

	# Friction
	current_velocity = lerp(current_velocity, Vector3.ZERO, FRICTION)

func _exit_tree() -> void:
	fsm.cleanup()
	fsm.free()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _construct_fsm_states() -> void:
	var idle: FSMState = load("res://entities/player/Idle.gd").new()
	idle.name = "Idle"
	var move: FSMState = load("res://entities/player/Move.gd").new()
	move.name = "Move"
	var jump: FSMState = load("res://entities/player/Jump.gd").new()
	jump.name = "Jump"

	self.fsm = FSM.new(self, [idle, move, jump], idle)

###############################################################################
# Public functions                                                            #
###############################################################################



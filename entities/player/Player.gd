class_name Player
extends KinematicBody

const ROTATION_EIGTH: float = PI / 4
const ROTATION_FULL: float = 2 * PI

const FRICTION: float = 0.1
const SPEED: float = 200.0
const JUMP: float = 200.0

onready var skeleton: Skeleton = $Skeleton

onready var anim_player: AnimationPlayer = $AnimationPlayer
var current_animation: String = "Idle"
var next_animation: String = "Idle"

var intended_velocity: Vector3 = Vector3.ZERO
var current_velocity: Vector3 = Vector3.ZERO

var fsm: FSM

onready var camera_mount: Spatial = $CameraMount
var current_camera_rotation: float = 0.0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	anim_player.play(current_animation)

	_construct_fsm_states()

func _physics_process(delta: float) -> void:
	# Camera control
	if camera_mount.rotation.y != current_camera_rotation:
		camera_mount.rotation.y = lerp(camera_mount.rotation.y, current_camera_rotation, 0.1)
	else:
		camera_mount.rotation.y = fposmod(current_camera_rotation, ROTATION_FULL)
	
	# Movement
	intended_velocity = Vector3.ZERO
	
	# Player input
	if Input.is_action_pressed("move_up"):
		intended_velocity.z += SPEED * delta
	if Input.is_action_pressed("move_down"):
		intended_velocity.z -= SPEED * delta
	if Input.is_action_pressed("move_left"):
		intended_velocity.x += SPEED * delta
	if Input.is_action_pressed("move_right"):
		intended_velocity.x -= SPEED * delta
	if Input.is_action_just_pressed("jump"):
		intended_velocity.y += JUMP

	# Gravity
	intended_velocity.y -= 10

	fsm.run(delta)

	# Friction
	current_velocity = lerp(current_velocity, Vector3.ZERO, 0.1)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate_camera_right"):
		current_camera_rotation += ROTATION_EIGTH
	elif event.is_action_pressed("rotate_camera_left"):
		current_camera_rotation -= ROTATION_EIGTH

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _construct_fsm_states() -> void:
	var idle: FSMState = load("res://entities/player/Idle.gd").new()
	var move: FSMState = load("res://entities/player/Move.gd").new()

	self.fsm = FSM.new(self, [idle, move], idle)

###############################################################################
# Public functions                                                            #
###############################################################################



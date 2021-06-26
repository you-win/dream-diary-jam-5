extends Node

const SPACING: float = 0.4

var counter: float = 0.0
var can_play_sound: bool = true

onready var step0: AudioStreamPlayer = $Step0
onready var step1: AudioStreamPlayer = $Step1
onready var step2: AudioStreamPlayer = $Step2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _physics_process(delta: float) -> void:
	if counter >= SPACING:
		can_play_sound = true
		counter = 0.0
	else:
		counter += delta

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func play_step_sound() -> void:
	if can_play_sound:
		var n: int = GameManager.rng.randi_range(0, 2)
		(self.get("step%s" % n) as AudioStreamPlayer).play(0)
		can_play_sound = false

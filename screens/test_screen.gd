extends Spatial

onready var player = find_node("Player")

onready var player_state_label = find_node("PlayerStateLabel")

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	player_state_label.text = "Player state: %s" % player.fsm.current_state.name

func _exit_tree() -> void:
	player = null
	player_state_label = null

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



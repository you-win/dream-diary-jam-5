extends BaseChunk

onready var spinners_x: Node = $SpinnersX
onready var spinners: Node = $Spinners

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	surrounding_chunks["Chunk200"] = "res://screens/levels/noneuclidian-dream/chunks/Chunk200.tscn"
	surrounding_chunks["Chunk202"] = "res://screens/levels/noneuclidian-dream/chunks/Chunk202.tscn"

func _physics_process(delta: float) -> void:
	for c in spinners_x.get_children():
		c.rotate_x(delta)
	for c in spinners.get_children():
		c.rotate_y(delta)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



extends BaseChunk

onready var spinning_ring: Spatial = $SpinningRing

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	surrounding_chunks["Chunk001"] = "res://screens/levels/noneuclidian-dream/chunks/Chunk001.tscn"
	surrounding_chunks["Chunk102"] = "res://screens/levels/noneuclidian-dream/chunks/Chunk102.tscn"

func _physics_process(delta: float) -> void:
	spinning_ring.rotate_z(delta)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



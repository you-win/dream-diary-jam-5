class_name BaseChunk
extends Spatial

signal should_load_chunks(chunk_name, surrounding_chunks)

onready var area: Area = $MeshInstance/Area

var surrounding_chunks: Dictionary = {}

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	area.connect("body_entered", self, "_on_body_entered")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_body_entered(body: Node) -> void:
	GameManager.log_message("%s" % self.name)
	if body.is_in_group("Player"):
		GameManager.log_message("sending it")
		emit_signal("should_load_chunks", self.name, surrounding_chunks)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



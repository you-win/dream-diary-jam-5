class_name BaseItem
extends Spatial

onready var mesh_parent: Spatial = $MeshParent

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func equip() -> Tuple2:
	GameManager.log_message("Not yet implemented for %s" % self.name, true)
	return null

func use() -> Tuple2:
	GameManager.log_message("Not yet implemented for %s" % self.name, true)
	return null

func inspect() -> Tuple2:
	GameManager.log_message("Not yet implemented for %s" % self.name, true)
	return null

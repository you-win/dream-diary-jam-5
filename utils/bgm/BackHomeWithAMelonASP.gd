extends AudioStreamPlayer

onready var tween: Tween = $Tween

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	tween.interpolate_property(self, "volume_db", -10.0, 0, 0.5)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



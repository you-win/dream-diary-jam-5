extends Spatial

onready var area: Area = $Area

var can_interact: bool = false

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	area.connect("body_entered", self, "_on_body_entered")
	area.connect("body_exited", self, "_on_body_exited")

func _unhandled_input(event: InputEvent) -> void:
	pass

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(GameManager.PLAYER_GROUP):
		can_interact = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group(GameManager.PLAYER_GROUP):
		can_interact = false

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



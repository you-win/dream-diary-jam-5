extends Spatial

var can_interact: bool = false

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$Area.connect("body_entered", self, "_on_body_entered")
	$Area.connect("body_exited", self, "_on_body_exited")

func _unhandled_input(event: InputEvent) -> void:
	if (can_interact and event.is_action_pressed("interact")):
		get_tree().change_scene("res://screens/levels/DreamHub.tscn")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		can_interact = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		can_interact = false

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



class_name BaseItem
extends Spatial

signal interacted(item_name)

onready var mesh_parent: Spatial = $MeshParent

export var item_name: String = "ChangeMe"

var can_interact: bool = false

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$Area.connect("body_entered", self, "_on_body_entered")
	$Area.connect("body_exited", self, "_on_body_exited")
	
	self.connect("interacted", GameManager.main.get_node("GUI"), "add_item")

func _unhandled_input(event: InputEvent) -> void:
	if (can_interact and event.is_action_pressed("interact")):
		_interact()

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

func _interact() -> void:
	queue_free()
	
	emit_signal("interacted", self.item_name)

###############################################################################
# Public functions                                                            #
###############################################################################

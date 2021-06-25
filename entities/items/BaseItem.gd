class_name BaseItem
extends Spatial

onready var mesh_parent: Spatial = $MeshParent

var can_interact: bool = false

class BBTagInfo:
	var _tag_name: String
	var _tag_param_1: String # NOTE unused in this project
	var _tag_param_2: String
	var _tag_param_3: String
	
	func _init(tag_name: String, param_1: String = "", param_2: String = "", param_3 = "") -> void:
		_tag_name = tag_name
		_tag_param_1 = param_1
		_tag_param_2 = param_2
		_tag_param_3 = param_3
	
	func open_tag() -> String:
		var result: String = ""
		
		match _tag_name:
			"wave":
				if _tag_param_1.empty():
					_tag_param_1 = "50"
				if _tag_param_2.empty():
					_tag_param_2 = "2"
				result = "[wave amp=%s freq=%s]" % [_tag_param_1, _tag_param_2]
			"tornado":
				if _tag_param_1.empty():
					_tag_param_1 = "5"
				if _tag_param_2.empty():
					_tag_param_2 = "2"
				result = "[tornado radius=%s freq=%s]" % [_tag_param_1, _tag_param_2]
			"shake":
				if _tag_param_1.empty():
					_tag_param_1 = "5"
				if _tag_param_2.empty():
					_tag_param_2 = "10"
				result = "[shake rate=%s level=%s]" % [_tag_param_1, _tag_param_2]
			"fade":
				if _tag_param_1.empty():
					_tag_param_1 = "4"
				if _tag_param_2.empty():
					_tag_param_2 = "14"
				result = "[fade start=%s length=%s]" % [_tag_param_1, _tag_param_2]
			"rainbow":
				if _tag_param_1.empty():
					_tag_param_1 = "0.2"
				if _tag_param_2.empty():
					_tag_param_2 = "10"
				if _tag_param_2.empty():
					_tag_param_2 = "20"
				result = "[rainbow freq=%s sat=%s val=%s]" % [_tag_param_1, _tag_param_2, _tag_param_3]
		
		return result
	
	func close_tag() -> String:
		return "[/%s]" % _tag_name

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$Area.connect("body_entered", self, "_on_body_entered")
	$Area.connect("body_exited", self, "_on_body_exited")

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

func _interact() -> Tuple2:
	push_error("Not yet implemented.")
	return null

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

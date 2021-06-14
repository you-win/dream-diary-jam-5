extends MarginContainer

onready var base: Label = $Base
onready var top: Label = $Top

var text_to_type: String = ""
var text_to_type_length: int

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	text_to_type_length = text_to_type.length()
	base.text = text_to_type
	top.text = text_to_type

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func update_text(current_input: String) -> bool:
	if current_input.empty():
		return false
	
	var new_visible_characters = 0
	var current_input_length = current_input.length()
	
	var has_space_at_end: bool = false
	if current_input[current_input_length - 1] == " ":
		has_space_at_end = true
		current_input.trim_suffix(" ")
	
	# Check for visible characters
	if(current_input_length > 0 and current_input_length <= text_to_type_length):
		for i in current_input_length:
			if text_to_type[i] == current_input[i]:
				new_visible_characters += 1
			else:
				new_visible_characters = 0
				return false
	
	# Check for space after word
	if (new_visible_characters == text_to_type_length and has_space_at_end):
		return true
	
	top.visible_characters = new_visible_characters
	
	# Only reachable if the user has not pressed space but has completed the word
	return false

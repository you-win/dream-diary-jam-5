extends Node2D

const TextLine: Resource = preload("res://screens/typing-game/TypingText.tscn")

# TODO load in an external word list
const WORD_LIST = [
	"hello", "world", "the", "a", "is", "if", "computer", "pasta", "parliament",
	"programmer", "yes", "no", "caoutchouc", "margin", "container", "canvas",
	"layer", "line", "edit", "max", "resource", "ready", "delta", "beta",
	"alpha", "gamma", "epsilon", "cartouche", "touche", "butt", "but", "pickle",
	"show", "constant", "umlaut", "nation", "country"
]

const MAX_LINE_LENGTH: int = 69

onready var text_line_container: VBoxContainer = $CanvasLayer/MarginContainer/MarginContainer/TextLineContainer

onready var line_edit: LineEdit = $LineEdit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	for i in 3:
		var hbox_container: HBoxContainer = HBoxContainer.new()
		_generate_words_for_container(hbox_container)
		text_line_container.add_child(hbox_container)

func _process(_delta: float) -> void:
	pass

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _generate_words_for_container(hbox: HBoxContainer) -> void:
	var word_list: Array = WORD_LIST.duplicate(true)
	word_list.shuffle()
	
	var current_line_length: int = 0
	
	while true:
		var word: String = word_list.pop_back()
		current_line_length += word.length()
		if current_line_length > MAX_LINE_LENGTH:
			break
		
		var text_line = TextLine.instance()
		text_line.text_to_type = word
		hbox.add_child(text_line)

###############################################################################
# Public functions                                                            #
###############################################################################

func start() -> void:
	line_edit.grab_focus()

func end() -> void:
	line_edit.release_focus()

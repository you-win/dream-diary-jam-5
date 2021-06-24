extends CanvasLayer

const GameGUI: Resource = preload("res://screens/gui/GUI.tscn")

onready var continue_button: Button = $MarginContainer/MarginContainer/VBoxContainer/Continue
onready var start_button: Button = $MarginContainer/MarginContainer/VBoxContainer/Start
onready var options_button: Button = $MarginContainer/MarginContainer/VBoxContainer/Options
onready var quit_button: Button = $MarginContainer/MarginContainer/VBoxContainer/Quit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	continue_button.connect("pressed", self, "_on_continue")
	start_button.connect("pressed", self, "_on_start")
	options_button.connect("pressed", self, "_on_options")
	quit_button.connect("pressed", self, "_on_quit")
	
	if not GameManager.does_metadata_exist():
		continue_button.visible = false

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_continue() -> void:
	pass

func _on_start() -> void:
	GameManager.main.change_scene("res://screens/RealWorldHub.tscn")
	
	var game_gui: CanvasLayer = GameGUI.instance()
	GameManager.main.call_deferred("add_child", game_gui)
	
	self.queue_free()

func _on_options() -> void:
	pass

func _on_quit() -> void:
	get_tree().quit()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



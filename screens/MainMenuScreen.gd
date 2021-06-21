extends Spatial

onready var continue_button: Button = $CanvasLayer/MarginContainer/MarginContainer/VBoxContainer/Continue
onready var start_button: Button = $CanvasLayer/MarginContainer/MarginContainer/VBoxContainer/Start
onready var options_button: Button = $CanvasLayer/MarginContainer/MarginContainer/VBoxContainer/Options
onready var quit_button: Button = $CanvasLayer/MarginContainer/MarginContainer/VBoxContainer/Quit

onready var csg_box: Spatial = $CSGBox
onready var camera_pivot: Spatial = $CameraPivot

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

func _physics_process(delta: float) -> void:
	camera_pivot.rotate_y(0.005)
	csg_box.rotate_x(0.025)
	csg_box.rotate_y(0.025)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_continue() -> void:
	pass

func _on_start() -> void:
	get_tree().change_scene("res://screens/MainDisplay.tscn")

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



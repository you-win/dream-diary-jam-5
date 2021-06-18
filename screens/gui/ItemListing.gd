class_name ItemListing
extends MarginContainer

signal action_pressed(item_name, action_name)

onready var item_label: Label = $MarginContainer/HBoxContainer/ItemLabel

onready var equip: Button = $MarginContainer/HBoxContainer/HBoxContainer/Equip
onready var use: Button = $MarginContainer/HBoxContainer/HBoxContainer/Use
onready var inspect: Button = $MarginContainer/HBoxContainer/HBoxContainer/Inspect

var item_label_text: String = ""

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	item_label.text = item_label_text
	
	equip.connect("pressed", self, "_on_equip")
	use.connect("pressed", self, "_on_use")
	inspect.connect("pressed", self, "_on_inspect")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_equip() -> void:
	emit_signal("action_pressed", item_label_text, "equip")

func _on_use() -> void:
	emit_signal("action_pressed", item_label_text, "use")

func _on_inspect() -> void:
	emit_signal("action_pressed", item_label_text, "inspect")

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



extends CanvasLayer

const ItemListing: Resource = preload("res://screens/gui/ItemListing.tscn")

onready var super_container: MarginContainer = $SuperContainer
onready var inventory: VBoxContainer = $SuperContainer/MarginContainer/HBoxContainer/RightContainer/MarginContainer/MarginContainer/InventoryScroll/Inventory

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	add_item("Flute", {})

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_ui"):
		super_container.visible = not super_container.visible

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_inventory_action(item_name: String, action_name: String) -> void:
	match item_name:
		"Flute":
			match action_name:
				"equip":
					pass
				"use":
					GameManager.log_message("%s: %s" % [item_name, action_name])
				"inspect":
					pass

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func add_item(item_name: String, _data: Dictionary) -> void:
	var item_listing: ItemListing = ItemListing.instance()
	item_listing.item_label_text = item_name
	inventory.add_child(item_listing)
	item_listing.connect("action_pressed", self, "_on_inventory_action")

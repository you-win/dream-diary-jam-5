extends CanvasLayer

const ItemListing: Resource = preload("res://screens/gui/ItemListing.tscn")

const MAX_LOGS: int = 50

onready var super_container: MarginContainer = $SuperContainer
onready var inventory: VBoxContainer = $SuperContainer/MarginContainer/HBoxContainer/RightContainer/InventoryContainer/MarginContainer/InventoryScroll/Inventory
onready var console: VBoxContainer = $SuperContainer/MarginContainer/HBoxContainer/RightContainer/ConsoleContainer/MarginContainer/ScrollContainer/Console

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	add_item("Flute")

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
					add_fancy_log([
						{
							"text": "You ",
							"effects": ["normal"]
						},
						{
							"text": "tried ",
							"effects": ["wave", "shake"]
						},
						{
							"text": "to equip the flute.",
							"effects": ["normal"]
						},
						{
							"text": " It didn't work.",
							"effects": ["fade"]
						}
					])
				"use":
					add_regular_log("You tried to play the flute. You really should have practiced more.")
					
					GameManager.main.change_scene("res://screens/levels/DreamHub.tscn")
				"inspect":
					add_regular_log("A flute. You don't remember when you bought this.")
		"Forest Key":
			match action_name:
				"equip":
					add_regular_log("You firmly grasped the key. Nothing happens.")
				"use":
					add_fancy_log([
						{
							"text": "You ",
							"effects": ["normal"]
						},
						{
							"text": "wiggled ",
							"effects": ["wave", "shake"]
						},
						{
							"text": "the key around in front of you.",
							"effects": ["normal"]
						}
					])
					
					# Check if in dream hub, if so, allow entry to new zone
					var dream_hub = GameManager.main.viewport.get_node_or_null("DreamHub")
					if dream_hub:
						dream_hub.billboard_blocker.queue_free()
						add_regular_log("You feel like something is different.")
				"inspect":
					add_fancy_log([
						{
							"text": "It's a very ",
							"effects": ["normal"]
						},
						{
							"text": "grassy ",
							"effects": ["shake"]
						},
						{
							"text": "key.",
							"effects": ["normal"]
						}
					])
		"Museum Device":
			match action_name:
				"equip":
					add_regular_log("The device is too big for you to equip.")
				"use":
					add_regular_log("You mash some buttons on the device.")
					add_fancy_log([
						{
							"text": "Some ",
							"effects": ["normal"]
						},
						{
							"text": "crazy ",
							"effects": ["wave", "shake"]
						},
						{
							"text": "text appears on the screen.",
							"effects": ["normal"]
						}
					])
					# Check if in dream hub, if so, allow entry to new zone
					var dream_hub = GameManager.main.viewport.get_node_or_null("DreamHub")
					if dream_hub:
						dream_hub.museum_blocker.queue_free()
						add_regular_log("You feel like something is gone.")
				"inspect":
					add_fancy_log([
						{
							"text": "'Who ",
							"effects": ["normal"]
						},
						{
							"text": "made this!?",
							"effects": ["wave", "shake"]
						},
						{
							"text": "' You think to yourself.",
							"effects": ["normal"]
						}
					])

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func add_item(item_name: String) -> void:
	var item_listing: ItemListing = ItemListing.instance()
	item_listing.item_label_text = item_name
	inventory.add_child(item_listing)
	item_listing.connect("action_pressed", self, "_on_inventory_action")

func add_regular_log(message: String) -> void:
	var label: Label = Label.new()
	label.text = message
	console.add_child(label)
	
	console.move_child(label, 0)
	
	while console.get_child_count() > MAX_LOGS:
		console.get_child(console.get_child_count() - 1).free()

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

func add_fancy_log(messages: Array) -> void:
	"""
	messages is an array of dictionaries
	[
		{
			"text": <some_text>,
			"effects":
			[
				string
			]
		}
	]
	"""
	var rtl: RichTextLabel = RichTextLabel.new()
	rtl.bbcode_enabled = true
	rtl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rtl.fit_content_height = true
	
	for m in messages:
		var text = m["text"]
		var tags: Array = [] # BBTagInfo
		for e in m["effects"]:
			match e.to_lower():
				"normal":
					break
				"wave":
					tags.append(BBTagInfo.new("wave"))
				"tornado":
					tags.append(BBTagInfo.new("tornado"))
				"shake":
					tags.append(BBTagInfo.new("shake"))
				"fade":
					tags.append(BBTagInfo.new("fade"))
				"rainbow":
					tags.append(BBTagInfo.new("rainbow"))
		var combined_tags: Array = []
		var open_tags: Array = []
		var close_tags: Array = []
		for t in tags:
			open_tags.append(t.open_tag())
			close_tags.push_front(t.close_tag())
		combined_tags.append_array(open_tags)
		combined_tags.append(text)
		combined_tags.append_array(close_tags)
		
		var formatted_string: String = "%s"
		for i in tags.size():
			formatted_string += "%s%s"
		
		var final_string = formatted_string % combined_tags
		rtl.append_bbcode(final_string)
		
	console.add_child(rtl)

	console.move_child(rtl, 0)

	while console.get_child_count() > MAX_LOGS:
		console.get_child(console.get_child_count() - 1).free()

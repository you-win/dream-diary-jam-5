extends Node

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _cleanup_asps() -> void:
	if get_child_count() > 0:
		for c in get_children():
			c.queue_free()

###############################################################################
# Public functions                                                            #
###############################################################################

func stop_music() -> void:
	_cleanup_asps()

func play_main_menu_music() -> void:
	_cleanup_asps()
	
	var main_menu_asp: AudioStreamPlayer = load("res://utils/bgm/MainMenuASP.tscn").instance()
	
	call_deferred("add_child", main_menu_asp)

func play_dream_hub_music() -> void:
	_cleanup_asps()
	
	var not_so_quietly_asp: AudioStreamPlayer = load("res://utils/bgm/NotSoQuietlyASP.tscn").instance()
	
	call_deferred("add_child", not_so_quietly_asp)

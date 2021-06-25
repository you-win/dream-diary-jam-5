extends Node

enum Track { NONE = 0, THE_DAYS_BLEND_TOGETHER, NOT_SO_QUIETLY, BACK_HOME_WITH_A_MELON }

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

func play_music(track_type: int = Track.NONE) -> void:
	_cleanup_asps()
	
	var asp: AudioStreamPlayer
	
	match track_type:
		Track.NONE:
			push_error("Track type not specified")
			return
		Track.THE_DAYS_BLEND_TOGETHER:
			asp = load("res://utils/bgm/MainMenuASP.tscn").instance()
		Track.NOT_SO_QUIETLY:
			asp = load("res://utils/bgm/NotSoQuietlyASP.tscn").instance()
		Track.BACK_HOME_WITH_A_MELON:
			asp = load("res://utils/bgm/BackHomeWithAMelonASP.tscn").instance()
		_:
			push_error("Track type not specified")
			return
	
	call_deferred("add_child", asp)

func play_main_menu_music() -> void:
	_cleanup_asps()
	
	var main_menu_asp: AudioStreamPlayer = load("res://utils/bgm/MainMenuASP.tscn").instance()
	
	call_deferred("add_child", main_menu_asp)

func play_dream_hub_music() -> void:
	_cleanup_asps()
	
	var not_so_quietly_asp: AudioStreamPlayer = load("res://utils/bgm/NotSoQuietlyASP.tscn").instance()
	
	call_deferred("add_child", not_so_quietly_asp)

func play_tower_top_music() -> void:
	_cleanup_asps()
	
	var back_home_with_melon_asp: AudioStreamPlayer = load("res://utils/bgm/BackHomeWithAMelonASP.tscn").instance()
	
	call_deferred("add_child", back_home_with_melon_asp)

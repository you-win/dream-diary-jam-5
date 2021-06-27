extends BaseChunk

onready var spotlight: SpotLight = $SpotLight
onready var spotlight_tween: Tween = $SpotLight/Tween

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	surrounding_chunks["Chunk002"] = "res://screens/levels/noneuclidian-dream/chunks/Chunk002.tscn"
	surrounding_chunks["Chunk202"] = "res://screens/levels/noneuclidian-dream/chunks/Chunk202.tscn"
	
	spotlight_tween.connect("tween_all_completed", self, "_on_swing_back")
	spotlight_tween.interpolate_property(spotlight, "rotation_degrees:z", -110.0, -70.0, 5.0)
	spotlight_tween.start()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_swing_back() -> void:
	spotlight_tween.disconnect("tween_all_completed", self, "_on_swing_back")
	spotlight_tween.connect("tween_all_completed", self, "_on_swing_forth")
	
	spotlight_tween.interpolate_property(spotlight, "rotation_degrees:x", -70.0, -110.0, 5.0,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	spotlight_tween.start()

func _on_swing_forth() -> void:
	spotlight_tween.disconnect("tween_all_completed", self, "_on_swing_forth")
	spotlight_tween.connect("tween_all_completed", self, "_on_swing_back")
	
	spotlight_tween.interpolate_property(spotlight, "rotation_degrees:x", -110.0, -70.0, 5.0,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	spotlight_tween.start()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



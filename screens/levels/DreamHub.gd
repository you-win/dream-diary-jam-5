extends Spatial

onready var billboard_blocker: StaticBody = $ForestGate/BillboardBlocker
onready var museum_blocker: StaticBody = $ForestGate/MuseumBlocker

var player

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$ForestGate/Area.connect("body_entered", self, "_on_forest_gate_entered")
	$BillboardGate/Area.connect("body_entered", self, "_on_billboard_gate_entered")
	$NoneuclidianGate/Area.connect("body_entered", self, "_on_noneclidian_gate_entered")
	
	player = get_node("Player")
	
	yield(get_tree(), "idle_frame")
	
	BGM.play_music(BGM.Track.NOT_SO_QUIETLY)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_forest_gate_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		GameManager.main.change_scene("res://screens/levels/forest-dream/ForestDream.tscn")

func _on_billboard_gate_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		GameManager.main.change_scene("res://screens/levels/billboard-dream/BillboardDream.tscn")

func _on_noneclidian_gate_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		GameManager.main.change_scene("res://screens/levels/noneuclidian-dream/NoneuclidianDream.tscn")

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



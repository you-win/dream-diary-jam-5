extends Spatial

onready var forest_gate_blocker: int = $ForestGate/Blocker.get_instance_id()

var player

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$ForestGate/Area.connect("body_entered", self, "_on_forest_gate_entered")
	$BillboardGate/Area.connect("body_entered", self, "_on_billboard_gate_entered")
	$NoneuclidianGate/Area.connect("body_entered", self, "_on_noneclidian_gate_entered")
	
	player = get_node("Player")

func _process(delta: float) -> void:
	if player.get_slide_count() > 1:
		for c in player.get_slide_count():
			var collision: KinematicCollision = player.get_slide_collision(c)
			if collision.collider_id != forest_gate_blocker:
				continue
			
			# if player.item == something
			# $ForestGate/Blocker.queue_free()

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



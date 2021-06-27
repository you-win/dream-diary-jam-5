extends Spatial

const FarBuildings: Resource = preload("res://screens/levels/forest-dream/the-tower/FarBuildings.tscn")
const CreditsScroll: Resource = preload("res://screens/levels/forest-dream/the-tower/CreditsScroll.tscn")

const DarkEnv: Resource = preload("res://assets/dark_env.tres")
const TowerEnv: Resource = preload("res://assets/tower_env.tres")

onready var world_environment: WorldEnvironment = $WorldEnvironment

onready var player: Player2DLocked = $Player2DLocked
onready var tween: Tween = $Tween

var far_buildings: Spatial

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	far_buildings = FarBuildings.instance()
	
	yield(get_tree(), "idle_frame")
	
	$TopPlatform/LoadFarBuildingsTrigger.connect("body_entered", self, "_on_load_far_buildings")
	$TopPlatform/LoadFarBuildingsTrigger.connect("body_exited", self, "_on_unload_far_buildings")

func _exit_tree() -> void:
	far_buildings.queue_free()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_load_far_buildings(body: Node) -> void:
	if body.is_in_group(GameManager.PLAYER_GROUP):
		call_deferred("add_child", far_buildings)
		world_environment.environment = TowerEnv
		tween.interpolate_property(player.camera, "rotation_degrees", Vector3(-23, 180, 0), Vector3(0, 180, 0), 3.0)
		tween.start()
		
		if not GameManager.main.get_node_or_null("credits"):
			var credits: Control = CreditsScroll.instance()
			credits.name = "credits"
			GameManager.main.call_deferred("add_child", credits)
		
		BGM.play_music(BGM.Track.BACK_HOME_WITH_A_MELON)

func _on_unload_far_buildings(body: Node) -> void:
	if body.is_in_group(GameManager.PLAYER_GROUP):
		call_deferred("remove_child", far_buildings)
		world_environment.environment = DarkEnv
		tween.interpolate_property(player.camera, "rotation_degrees", Vector3(0, 180, 0), Vector3(-23, 180, 0), 3.0)
		tween.start()
		
		var credits = GameManager.main.get_node_or_null("credits")
		if credits:
			credits.call_deferred("queue_free")
		
		BGM.play_music(BGM.Track.NOT_SO_QUIETLY)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



extends CanvasLayer

const TransitionScreen: Resource = preload("res://screens/TransitionScreen.tscn")

onready var viewport: Viewport = $ViewportContainer/Viewport

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	GameManager.main = self

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func change_scene(path: String) -> void:
	var new_scene: Spatial = load(path).instance()
	
	var transition_screen: Control = TransitionScreen.instance()
	var image_data: Image = viewport.get_texture().get_data()
	image_data.flip_y()
	transition_screen.last_screen_image = image_data
	transition_screen.viewport_size = viewport.size
	
	viewport.get_child(0).queue_free()
	viewport.call_deferred("add_child", new_scene)
	viewport.call_deferred("add_child", transition_screen)

extends Spatial

onready var viewport: Viewport = $Viewport

onready var typing_game: Node2D = $Viewport/TypingGame

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	$Screen.material_override.albedo_texture = viewport.get_texture()

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_0):
		pass

func _exit_tree() -> void:
	if typing_game:
		typing_game.free()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



extends Control

const TWEEN_DURATION: float = 1.0
const CLEAR_COLOR: Color = Color(0.0, 0.0, 0.0, 0.0)

onready var black_background: ColorRect = $BlackBackground
onready var texture_rect: TextureRect = $TextureRect
onready var color_rect: ColorRect = $ColorRect
onready var tween: Tween = $Tween

var last_screen_image: Image
var viewport_size: Vector2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	var image_texture := ImageTexture.new()
	image_texture.create_from_image(last_screen_image)
	texture_rect.texture = image_texture
	texture_rect.rect_pivot_offset = (viewport_size / 2)
	
	tween.connect("tween_all_completed", self, "_on_first_tween_complete")
	tween.interpolate_property(color_rect, "color", CLEAR_COLOR, Color.black, TWEEN_DURATION)
	tween.interpolate_property(texture_rect, "rect_rotation", 0.0, 360, TWEEN_DURATION)
	tween.interpolate_property(texture_rect, "rect_scale", Vector2.ONE, Vector2.ZERO, TWEEN_DURATION)
	tween.start()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_first_tween_complete() -> void:
	tween.disconnect("tween_all_completed", self, "_on_first_tween_complete")
	texture_rect.visible = false
	black_background.visible = false
	
	tween.connect("tween_all_completed", self, "_on_second_tween_complete")
	tween.interpolate_property(self, "modulate", Color.white, CLEAR_COLOR, TWEEN_DURATION)
	tween.start()

func _on_second_tween_complete() -> void:
	queue_free()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



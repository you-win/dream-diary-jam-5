extends Spatial

onready var area: Area = $Area

onready var music: Node = $Music

var is_player_in_range: bool = false

var music_track_size: int
var current_track: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	area.connect("body_entered", self, "_on_body_entered")
	area.connect("body_exited", self, "_on_body_exited")
	
	music_track_size = music.get_child_count()
	
	play_next_track()

func _unhandled_input(_event: InputEvent) -> void:
	if (is_player_in_range and Input.is_action_just_pressed("interact")):
		play_next_track()
		if get_node_or_null("Sprite3D"):
			$Sprite3D.queue_free()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(GameManager.PLAYER_GROUP):
		is_player_in_range = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group(GameManager.PLAYER_GROUP):
		is_player_in_range = false

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func play_next_track() -> void:
	match current_track:
		0:
			music.get_child(0).stream_paused = false
			current_track = 1
		1:
			music.get_child(0).stream_paused = true
			music.get_child(1).stream_paused = false
			current_track = 2
		2:
			for c in music.get_children():
				c.stream_paused = true
			current_track = 0

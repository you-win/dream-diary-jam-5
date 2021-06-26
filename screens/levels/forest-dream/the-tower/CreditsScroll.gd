extends Control

const CREDIT_PAUSE_TIME: float = 3.0
const CREDIT_SPEED: float = 200.0

onready var center_container: CenterContainer = $CenterContainer
onready var timer: Timer = $Timer
onready var labels: Node = $Labels

var credits: Array = [
	"Thanks for playing!",
	"Made by Timothy Yuen",
	"Twitch: team_youwin",
	"Twitter: @team_youwin",
	"Github: you-win",
	"Itch.io: fakefirefly",
	"Made for the Dream Diary Jam 5"
]

var credit_counter: int = 0

var spawn_position: Vector2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	timer.connect("timeout", self, "_on_timeout")
	
	spawn_position = center_container.rect_position
	spawn_position.x += 100
	
	send_next_credit()
	
	timer.start(CREDIT_PAUSE_TIME)

func _physics_process(delta: float) -> void:
	var labels_to_free: Array = []
	for i in labels.get_children():
		var current_pos: Vector2 = i.get_global_position()
		var new_x: float = current_pos.x - (CREDIT_SPEED * delta)
		if new_x < -400:
			i.queue_free()
		else:
			i.set_global_position(Vector2(new_x, current_pos.y))

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_timeout() -> void:
	send_next_credit()
	
	timer.start(CREDIT_PAUSE_TIME)

###############################################################################
# Private functions                                                           #
###############################################################################

func send_next_credit() -> void:
	var label := Label.new()
	label.text = credits[credit_counter]
	label.set_global_position(spawn_position)
	label.rect_scale = Vector2(2, 2)
	
	labels.call_deferred("add_child", label)
	
	credit_counter += 1
	if credit_counter >= credits.size():
		credit_counter = 0

###############################################################################
# Public functions                                                            #
###############################################################################



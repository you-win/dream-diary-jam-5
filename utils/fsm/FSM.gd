class_name FSM
extends Object

var obj: Node

var states: Dictionary = {}

var last_state: FSMState
var current_state: FSMState
var next_state: FSMState

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _init(p_obj: Node, p_states: Array, p_starting_state: FSMState) -> void:
	self.obj = p_obj
	
	for state in p_states:
		state.fsm = self
		state.obj = p_obj
		self.states[state.name] = state
	
	last_state = p_starting_state
	current_state = p_starting_state
	next_state = p_starting_state

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func run(delta: float) -> void:
	if current_state != next_state:
		current_state.on_exit()
		next_state.on_enter()
		last_state = current_state
		current_state = next_state
	current_state.run(delta)

func switch_state_now(delta: float, state: FSMState) -> void:
	self.next_state = state
	run(delta)

func switch_state_deferred(state: FSMState) -> void:
	self.next_state = state

func cleanup() -> void:
	for state in states.keys():
		states[state].free()
	states.clear()
	self.obj = null

extends Spatial

onready var chunks: Node = $Chunks
var previous_chunk_name: String = ""
var previous_chunks: Array = []

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	for chunk in chunks.get_children():
		if not chunk.is_connected("should_load_chunks", self, "_load_surrounding_chunks"):
			chunk.connect("should_load_chunks", self, "_load_surrounding_chunks")
		previous_chunks.append(chunk.name)

###############################################################################
# Connections                                                                 #
###############################################################################

func _load_surrounding_chunks(chunk_name: String, surrounding_chunks: Dictionary) -> void:
	if chunk_name == previous_chunk_name:
		return
	else:
		previous_chunk_name = chunk_name
	
	var current_loaded_chunks: Array = [] # String
	for chunk in chunks.get_children():
		current_loaded_chunks.append(chunk.name)
	
	var combined_chunks: Array = previous_chunks.duplicate()
	previous_chunks.clear()
	
	# Add chunks
	for chunk_name in surrounding_chunks.keys():
		previous_chunks.append(chunk_name)
		if not combined_chunks.has(chunk_name):
			combined_chunks.append(chunk_name)
		if not current_loaded_chunks.has(chunk_name):
			var new_chunk: BaseChunk = load(surrounding_chunks[chunk_name]).instance()
			new_chunk.name = chunk_name
			new_chunk.connect("should_load_chunks", self, "_load_surrounding_chunks")
			chunks.call_deferred("add_child", new_chunk)
	
	# Unload chunks
	for chunk_name in current_loaded_chunks:
		if not chunk_name in combined_chunks:
			chunks.get_node(chunk_name).queue_free()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################



extends Node

var debug = true
var STATES = {}
var current_state = null
var next_state = null
var obj = null


func _init(obj, states_parent_node, initial_state, debug = true):
	self.obj = obj
	self.debug = debug
	_set_states_parent_node(states_parent_node)
	next_state = initial_state
	pass

func _set_states_parent_node( pnode ):
	if debug: print("Found ", pnode.get_child_count(), " states")
	if pnode.get_child_count() == 0:
		return
	var state_nodes = pnode.get_children()
	for state_node in state_nodes:
		if debug: print("adding state: ", state_node.name)
		STATES[state_node.name] = state_node


func run_machine(delta):
	if next_state != current_state:
		if current_state != null:
			if debug:
				print(obj.name, ": changing from state ", current_state.name, " to ", next_state.name)
			current_state.terminate(obj)
		elif debug:
			print(obj.name, ": starting with state ", next_state.name)
		current_state = next_state
		current_state.initialize(obj)
	# run state
	current_state.run(obj, delta)

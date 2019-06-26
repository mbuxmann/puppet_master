extends Node

var current_room 
var previous_room
var next_room

var camera_changed: bool = false

# warning-ignore:unused_argument
func _process(delta):
	if next_room != current_room:
		previous_room = current_room
		current_room = next_room
		change_camera()
	if camera_changed:
		restart_traps()
		camera_changed = false
	if GameManager.player_has_respawned:
		restart_traps()
		GameManager.player_has_respawned = false
		
func change_camera():
	# needs cleaning up
	if previous_room == null:
		print("Moved from: Room101 to: ", current_room.name)
	else:
		print("Moved from: ", previous_room.name, " to: ", current_room.name)
	RoomManager.next_room.get_node("Camera2D").current = true
	camera_changed = true
	
func restart_traps():
	if !current_room.get_node("FloorTraps"):
		print("no traps found")
	else:
		var floor_traps = current_room.get_node("FloorTraps").get_children()
		for trap in floor_traps:
			if GameManager.debug:
				print('resetting trap: ', trap.name)
			trap.reset_trap()
extends Node2D

class_name Door

export(NodePath) var next_room_target_node
export(bool) var opened

onready var next_room = get_node(next_room_target_node)

const OFFSET = 32
var door_position
var new_position = Vector2.ZERO
var target_door
var target_door_position

func _ready():
	door_position = get_global_position()
	if opened:
		$AnimationPlayer.play("DoorOpened")
	match name:
		"LeftDoor":
			target_door = "RightDoor"
		"RightDoor":
			target_door = "LeftDoor"
		"TopDoor":
			target_door = "BottomDoor"
		"BottomDoor":
			target_door = "TopDoor"
			 
# warning-ignore:unused_argument
func _process(delta):
	if !opened:
		$AnimationPlayer.play("DoorClosed")
	

func _on_EntranceDetector_body_entered(body):
	if body is Player:
		RoomManager.next_room = next_room
		var doors = next_room.get_node("Doors").get_children()
		for door in doors:
			if target_door == door.name:
				target_door_position = door.get_global_position()
		
		match name:
			"LeftDoor": 
				new_position = Vector2(target_door_position.x - OFFSET, body.position.y)
			"RightDoor":
				new_position = Vector2(target_door_position.x + OFFSET, body.position.y)
			"TopDoor":
				new_position = Vector2(body.position.x, target_door_position.y - OFFSET)
			"BottomDoor":
				new_position = Vector2(body.position.x, target_door_position.y + OFFSET)
			
		
		# Update body position and set new spawn position
		body.position = new_position
		body.spawn_position = body.get_position()
	

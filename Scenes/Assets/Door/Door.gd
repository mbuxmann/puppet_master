extends Node2D

class_name Door

export(NodePath) var door_target_node
export(NodePath) var camera_target_node
export(bool) var opened

onready var door_target = get_node(door_target_node)
onready var camera_target = get_node(camera_target_node)
onready var door_target_position = door_target.get_global_position()

const OFFSET = 50
var door_position
var new_position = Vector2.ZERO

func _ready():
	door_position = get_global_position()
	if opened:
		$AnimationPlayer.play("DoorOpened")

# warning-ignore:unused_argument
func _process(delta):
	if !opened:
		$AnimationPlayer.play("DoorClosed")
	

func _on_EntranceDetector_body_entered(body):
	if body is Player:
		match body.current_direction:
			body.direction.LEFT: 
				new_position = Vector2(door_target_position.x - OFFSET, body.position.y)
			body.direction.RIGHT:
				new_position = Vector2(door_target_position.x + OFFSET, body.position.y)
			body.direction.UP:
				new_position = Vector2(body.position.x, door_target_position.y - OFFSET)
			body.direction.DOWN:
				new_position = Vector2(body.position.x, door_target_position.y + OFFSET)
		
		body.position = new_position
		body.spawn_position = body.get_position()
	change_camera()
	
func change_camera():
	camera_target.current = true
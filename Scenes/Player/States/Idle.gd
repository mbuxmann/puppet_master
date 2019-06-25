extends "res://Scripts/state.gd"


func initialize(obj):
	match obj.current_direction:
		obj.direction.LEFT: obj.next_animation = "IdleLeft"
		obj.direction.RIGHT: obj.next_animation = "IdleRight"
		obj.direction.UP: obj.next_animation = "IdleUp"
		obj.direction.DOWN: obj.next_animation = "IdleDown"
		
# warning-ignore:unused_argument
func run(obj, delta):
	# player input
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or \
		Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
			obj.fsm.next_state = obj.fsm.STATES.Run

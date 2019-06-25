extends "res://Scripts/state.gd"

var is_moving = false

func initialize(obj):
	match obj.current_direction:
		obj.direction.LEFT: obj.next_animation = "RunLeft"
		obj.direction.RIGHT: obj.next_animation = "RunRight"
		obj.direction.UP: obj.next_animation = "RunUp"
		obj.direction.DOWN: obj.next_animation = "RunDown"
	
# warning-ignore:unused_argument
func run(obj, delta):
	if obj.motion.y > 0:
		obj.next_animation = "RunDown"
	elif obj.motion.y < 0:
		obj.next_animation = "RunUp"
	elif obj.motion.x > 0:
		obj.next_animation = "RunRight"
	elif obj.motion.x < 0:
		obj.next_animation = "RunLeft"
	
		
	get_input(obj)
	apply_movement(obj)

	if abs(obj.motion.length()) > 0:
		is_moving = true
	elif abs(obj.motion.length()) == 0:
		is_moving = false
	
	if !is_moving:
		obj.fsm.next_state = obj.fsm.STATES.Idle
	
func get_input(obj):
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	
	obj.motion.x = -int(LEFT) + int(RIGHT)
	obj.motion.y = -int(UP) + int(DOWN)
	
# warning-ignore:unused_argument
func apply_movement(obj):
	obj.motion = obj.motion.normalized() * obj.MAX_SPEED
	obj.move_and_slide(obj.motion, Vector2(0, 0))
	

extends KinematicBody2D
class_name Player

# warning-ignore:unused_class_variable
onready var HealthNode = $Health

const MAX_SPEED = 130

var fsm = null
# warning-ignore:unused_class_variable
var motion = Vector2.ZERO
var spawn_position = Vector2.ZERO
var current_animation
var current_direction
var next_animation
# warning-ignore:unused_class_variable
var is_hit: bool
# warning-ignore:unused_class_variable
var reset: bool = false
# warning-ignore:unused_class_variable
var debug = true

enum direction {
	LEFT,
	RIGHT,
	UP,
	DOWN
	}

func _ready():
	# Initialize states machine
	fsm = preload("res://Scripts/fsm.gd").new(self, $States, $States/Idle, false)
	spawn_position = get_position()
	
func _physics_process( delta ):
	# update states machine
	fsm.run_machine( delta )
	# direction
	if motion.x > 0:
		current_direction = direction.RIGHT
	if motion.x < 0:
		current_direction = direction.LEFT
	if motion.y < 0:
		current_direction = direction.UP
	if motion.y > 0:
		current_direction = direction.DOWN
		
	# update animations
	if next_animation != current_animation:
		current_animation = next_animation
		$AnimationPlayer.play(current_animation)
		
#========================
# dust functions
#========================

extends Area2D
class_name FloorTrap

export(String, "TrapNormal", "TrapLeft", "TrapMiddle", "TrapRight") var trap_used

var body_entered: bool = false
var trap_activated: bool = false
func _ready():
	match trap_used:
		"TrapNormal":
			$AnimationPlayer.play("TrapIdle")
		"TrapLeft":
			print('test')
			$AnimationPlayer.play("TrapIdleLeft")
		"TrapMiddle":
			$AnimationPlayer.play("TrapIdleMiddle")
		"TrapRight":
			$AnimationPlayer.play("TrapIdleRight")


func _on_FloorTrap_body_entered(body):
	if body is Player and !body_entered:
		body_entered = true # make false at reset
		$Timer.start()

func _on_Timer_timeout():
	activate_trap()

	
	
func activate_trap():
	match trap_used:
		"TrapNormal":
			$AnimationPlayer.play("TrapActivate")
		"TrapLeft":
			$AnimationPlayer.play("TrapActivateLeft")
		"TrapMiddle":
			$AnimationPlayer.play("TrapActivateMiddle")
		"TrapRight":
			$AnimationPlayer.play("TrapActivateRight")
	trap_activated = true
	
func _process(delta):
	if trap_activated:
		check_for_player()
	
func check_for_player():
	var body_list = get_overlapping_bodies()
	for body in body_list:
			if body is Player:
				body.fsm.next_state = body.fsm.STATES.Fall
			
				
func reset_trap():
	match trap_used:
		"TrapNormal":
			$AnimationPlayer.play("TrapIdle")
		"TrapLeft":
			$AnimationPlayer.play("TrapIdleLeft")
		"TrapMiddle":
			$AnimationPlayer.play("TrapIdleMiddle")
		"TrapRight":
			$AnimationPlayer.play("TrapIdleRight")
	body_entered = false

func _on_AnimationPlayer_animation_finished(anim_name):	
	if anim_name == "TrapActivateLeft" or anim_name == "TrapActivateMiddle" or \
		anim_name == "TrapActivateRight" or anim_name == "TrapActivate":
		trap_activated = false
	if (anim_name == "TrapActivateLeft" or anim_name == "TrapActivateMiddle" or \
		anim_name == "TrapActivateRight" or anim_name == "TrapActivate")  and game.player_has_fallen :
		print('true')
		reset_trap()

func _input(event):
	if event.is_action_pressed('z'):
		reset_trap()
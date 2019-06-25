extends Area2D
class_name FloorTrapNormal


var body_entered: bool = false

func _ready():
	
	$AnimationPlayer.play("Idle")


func _on_FloorTrapNormal_body_entered(body):
	if body is Player and !body_entered:
		body_entered = true # make false at reset
		$Timer.start()

func _on_Timer_timeout():
	activate_trap()
	check_for_player()
	
	
func activate_trap():
	$AnimationPlayer.play('Activate')

func check_for_player():
	var body_list = get_overlapping_bodies()
	for body in body_list:
			if body is Player:
				body.fsm.next_state = body.fsm.STATES.Fall
				
func reset_trap():
	$AnimationPlayer.play("Idle")
	body_entered = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Activate" and game.player_has_fallen:
		reset_trap()
		
func _input(event):
	if event.is_action_pressed('z'):
		reset_trap()
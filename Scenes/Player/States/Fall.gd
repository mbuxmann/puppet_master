extends "res://Scripts/state.gd"

var timer_finished: bool = false

func initialize(obj):
	GameManager.player_has_fallen = true
	obj.next_animation = "Falling"
	obj.HealthNode.take_damage(0.5)
	$Timer.start()
	
# warning-ignore:unused_argument
func run(obj, delta):
	if timer_finished:
		obj.fsm.next_state = obj.fsm.STATES.Idle
		obj.position = obj.spawn_position
		timer_finished = false
# warning-ignore:unused_argument
func terminate(obj):
	GameManager.player_has_fallen = false
	GameManager.player_has_respawned = true
	
	
func _on_Timer_timeout():
	timer_finished = true
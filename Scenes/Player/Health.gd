#extends Node
#
#onready var parent = get_parent()
##signal health_changed(new_health)
#signal damage_taken
#signal health_depleted()
#
#var health = 0
#export(int) var max_health = 9 setget set_max_health
#
#func _ready():
#	health = max_health
#
#func set_max_health(value):
#	max_health = max(0, value)
#
#func take_damage(amount):
#	health -= amount
#	health = max(0, health)
#	print(parent.get_name(), health)
##	emit_signal("health_changed", health)
#	emit_signal("damage_taken")
#	if health == 0:
#		emit_signal("health_depleted")
#
#func heal(amount):
#	health += amount
#	health = max(health, max_health)
##	emit_signal("health_changed", health)

extends Node

var max_health: float = 3.0
var health = max_health

func take_damage(amount):
	health -= amount
	health = max(0, health)
	if health == 0:
		print('dead')
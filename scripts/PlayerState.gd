extends Node


const MAX_HEALTH: int = 100

var health: int = MAX_HEALTH
var coins: int = 0


func increase_health(value: int) -> void:
	health = clampi(health + value, 0, MAX_HEALTH)
	# HUD.update_health()

func decrease_health(value: int) -> void:
	health = clampi(health - value, 0, MAX_HEALTH)
	# HUD.update_health()
	
func add_coins(value: int) -> void:
	coins += value
	# HUD.update_coins()

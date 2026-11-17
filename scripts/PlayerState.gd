extends Node

@onready var hud = get_node("/root/Hud")

const MAX_HEALTH: int = 100

var health: int = MAX_HEALTH
var coins: int = 0

var player_object: Player = null
var position_cache: Vector2 = Vector2(0, 0)


func increase_health(value: int) -> void:
	health = clampi(health + value, 0, MAX_HEALTH)
	hud.update_health(health)

func decrease_health(value: int) -> void:
	health = clampi(health - value, 0, MAX_HEALTH)
	hud.update_health(health)
	
func add_coins(value: int) -> void:
	coins += value
	hud.update_coins(coins)

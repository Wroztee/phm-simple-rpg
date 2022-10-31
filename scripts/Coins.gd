extends Area2D


export(int) var value = 5


func _on_Coins_area_entered(area):
	if area.is_in_group("Player"):
		area.collect_coins(value)
		queue_free()  # destroy the object

extends Area2D


@export var damage: int = 20


func _on_Cactus_area_entered(area):
	if area.is_in_group("Player"):
		area.get_hurt(damage)

extends Area2D


export(String) var next_scene = "res://scenes/House.tscn"
export(String) var message = "Press SPACE to enter."


var is_active = false


func _ready():
	$CanvasLayer/Label.text = message
	$CanvasLayer/Label.hide()

func _unhandled_input(event):
	if event.is_action_pressed("Action") and is_active:
		get_tree().change_scene(next_scene)


func _on_Teleport_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/Label.show()
		is_active = true


func _on_Teleport_area_exited(area):
	if area.is_in_group("Player"):
		$CanvasLayer/Label.hide()
		is_active = false

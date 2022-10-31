extends StaticBody2D


export(String) var message = ""


func _ready():
	$CanvasLayer/TextureRect/Label.text = message
	$CanvasLayer/TextureRect.hide()

func _on_CloseArea_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/TextureRect.show()


func _on_CloseArea_area_exited(area):
	if area.is_in_group("Player"):
		$CanvasLayer/TextureRect.hide()

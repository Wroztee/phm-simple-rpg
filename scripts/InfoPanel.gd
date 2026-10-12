extends StaticBody2D


@export var message: String = ""

@onready var message_label: Label = $CanvasLayer/TextureRect/Label
@onready var info_panel: TextureRect = $CanvasLayer/TextureRect


func _ready() -> void:
	message_label.text = message
	info_panel.hide()

func _on_close_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		info_panel.show()


func _on_close_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		info_panel.hide()

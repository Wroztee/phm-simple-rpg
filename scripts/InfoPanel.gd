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
		var panel_show_tween: Tween = create_tween()
		panel_show_tween.tween_property(info_panel, "position", Vector2(426, 120), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)


func _on_close_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		var panel_hide_tween: Tween = create_tween()
		panel_hide_tween.tween_property(info_panel, "position", Vector2(426, -160), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
		await  panel_hide_tween.finished
		info_panel.hide()

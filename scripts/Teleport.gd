extends Area2D


@export var next_scene: String = "res://scenes/House.tscn"
@export var message: String = "Press SPACE to enter."

var is_active: bool = false

@onready var prompt_label: Label = $CanvasLayer/Label

func _ready() -> void:
	prompt_label.text = message
	prompt_label.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Action") and is_active:
		get_tree().change_scene_to_file(next_scene)


func _on_teleport_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		prompt_label.show()
		is_active = true


func _on_teleport_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		prompt_label.hide()
		is_active = false

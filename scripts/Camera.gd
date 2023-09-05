extends Camera2D


@export var target_path: NodePath

var target = null


func _ready():
	if target_path != null:
		target = get_node(target_path)
		position = target.position

func _process(delta):
	if target != null:
		position = target.position

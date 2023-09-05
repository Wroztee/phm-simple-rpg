extends Camera2D


@export var target_path: NodePath

var target = null


func _ready():
	if target_path != null:
		target = get_node(target_path)
		position = target.position
		
		target.moved.connect(move_to_position)

func move_to_position():
	if target != null:
		position = target.position

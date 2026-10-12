extends Area2D


@export var speed: float = 4
signal moved

const TILE_SIZE: int = 16

const INPUTS: Dictionary[String, Vector2] = {
	"Left": Vector2.LEFT,
	"Right": Vector2.RIGHT,
	"Up": Vector2.UP,
	"Down": Vector2.DOWN
}

@onready var move_timer: Timer = $MoveTimer
@onready var ray_cast: RayCast2D = $RayCast2D

var last_dir: Vector2 = Vector2.ZERO
var last_action: String = ""

func _ready() -> void:
	# align position to the middle of a tile
	position = (position / TILE_SIZE).floor() * TILE_SIZE
	position += Vector2.ONE * TILE_SIZE / 2.0
	# set timer interval according to the speed
	move_timer.wait_time = 1.0/speed

func _unhandled_input(event: InputEvent) -> void:
	for action: String in INPUTS:
		if event.is_action_pressed(action):
			var dir: Vector2 = INPUTS[action]
			if move_tile(dir):
				# repeat the action in fixed intervals, if it is still pressed
				last_action = action
				last_dir = dir
				move_timer.start()

func move_tile(direction: Vector2) -> bool:
	ray_cast.target_position = direction * TILE_SIZE
	ray_cast.force_raycast_update()
	if !ray_cast.is_colliding():
		position += direction * TILE_SIZE
		moved.emit()
		return true
	return false

func _on_move_timer_timeout() -> void:
	if Input.is_action_pressed(last_action):
		if move_tile(last_dir):  # do the same move as the last time
			return
	# reset
	last_action = ""
	last_dir = Vector2.ZERO
	move_timer.stop()

func get_hurt(value: int) -> void:
	PlayerState.decrease_health(value)

func collect_coins(value: int) -> void:
	PlayerState.add_coins(value)

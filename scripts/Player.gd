extends Area2D

class_name Player


@export var speed: float = 4
@export var movement_anim_time: float = 0.15
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
var is_moving: bool = false

func _ready() -> void:
	PlayerState.player_object = self
	
	if PlayerState.position_cache != Vector2.ZERO:
		global_position = PlayerState.position_cache
		
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
	if !ray_cast.is_colliding() and !is_moving:
		animate_step(direction * TILE_SIZE)
		moved.emit()
		return true
		
	var collider: Object = ray_cast.get_collider()
	if collider is Cactus:
		get_hurt((collider as Cactus).damage)
	return false

func animate_step(step: Vector2) -> void:
	is_moving = true
	var movement_tween: Tween = create_tween()
	movement_tween.tween_property(self, "position", position + step, movement_anim_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	await movement_tween.finished
	is_moving = false

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
	

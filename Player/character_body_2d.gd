extends CharacterBody2D

@export var ACCELERATION = 5000
@export var FRICTION = 5000
@export var MAX_SPEED = 120

enum {IDLE, RUN}
var state = IDLE
@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_path =["parameters/idle/idle_bs2d/blend_position", "parameters/run/run_bs2d/blend_position"]

var animTree_state_keys = ["idle", "run"]

func _physics_process(delta: float) -> void:
	move(delta)
	animar()
	pass
	
func move(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
	else:
		state = RUN
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
		move_and_slide()
func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(a) -> void:
	velocity += a
	velocity = velocity.limit_length(MAX_SPEED)

func animar() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_path[state], blend_position)

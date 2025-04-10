extends CharacterBody2D

const speed = 200

# Referência ao AnimationPlayer
@onready var animation_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var sprite = $AnimatedSprite2D

@onready var state_machine = anim_tree.get("parameters/playback")

var input_direction = null

@export var start_direction : Vector2 = Vector2(0, 1)
func _ready() -> void:
	update_animation(start_direction)

func pegar_input():
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction.normalized() * speed
	
	
func _physics_process(delta: float) -> void:
	pegar_input()
	move_and_slide() 
	update_animation(input_direction)
	estado_animacao()

func update_animation(move_input: Vector2):
	
	if(move_input != Vector2.ZERO):
		anim_tree.set("parameters/idle/blend_position", move_input)
		anim_tree.set("parameters/walk/blend_position", move_input)

func estado_animacao():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")

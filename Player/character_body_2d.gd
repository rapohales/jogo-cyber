extends CharacterBody2D

const speed = 200

# Referência ao AnimationPlayer
@onready var animation_player = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D  # Assumindo que você tem um nó Sprite2D

func pegar_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
func _physics_process(delta: float) -> void:
	pegar_input()
	move_and_slide()

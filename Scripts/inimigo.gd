extends CharacterBody2D

@export var speed: float = 80
@export var player: Node2D  # Arraste o jogador para cá
@export var max_health: int = 100
@export var health: int = 100

@onready var sprite = $AnimatedSprite2D
var current_frame := 0
var animation_speed = 0.2  # Velocidade da animação
var timer = 0.0

func _ready():
	if player == null:
		player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		# Movimento
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		# Animação (muda os frames manualmente)
		animate_run(delta, direction)

func animate_run(delta: float, direction: Vector2):
	timer += delta
	if velocity.length() > 0:  # Se está se movendo
		# Vira o sprite conforme a direção
		sprite.flip_h = direction.x < 0
		
		# Troca os frames em um intervalo de tempo
		if timer >= animation_speed:
			timer = 0.0
			current_frame = (current_frame + 1) % 4
			sprite.frame = current_frame
	else:
		sprite.frame = 0  # Frame parado (idle)

extends Node2D
@export var damage = 40
@export var amount = 2
@export var speed = 500
@export var proj_cena: PackedScene
@export var fire_delay: float = 40
var is_right: bool = true
@onready var cooldown = $CoolDown
var player: Node2D 
var bullets_fired = 0
var is_firing = false
var muzzle: Node2D

func _ready():
	player = get_parent()
	if not player:
		push_error("Este nó não tem um parent!")
	muzzle = player.get_node_or_null("Muzzl")

func _process(delta: float) -> void:
	if player.velocity.x < 0:
		is_right = false
	elif player.velocity.x > 0:
		is_right = true

func ativar():
	if not player:
		print("n ta ativo")
		return
	if not muzzle:
		return
	bullets_fired = 0
	is_firing = true
	_fire_next_bullet()

func _fire_next_bullet():
	if bullets_fired >= amount:
		is_firing = false
		$TimeAlive.start(1)
		return
	var bullet = proj_cena.instantiate()
	get_parent().get_parent().add_child(bullet)

	var slash_anim = bullet.get_node("SlashSprite")
	if not slash_anim:
		print("Nao achou a animação SlashSprite")
	else:
		slash_anim.play("slash")
	
	if "speed" in bullet:
		bullet.speed = speed
	
	# Verifica a direção do movimento primeiro
	if player.velocity.x < 0:
		# Movendo para esquerda
		slash_anim.rotation_degrees = -90.0
		bullet.direction = Vector2.LEFT
		is_right = false
	elif player.velocity.x > 0:
		# Movendo para direita
		slash_anim.rotation_degrees = 90.0
		bullet.direction = Vector2.RIGHT
		is_right = true
	else:
		# Sem movimento, verifica a última animação
		var current_anim = player.get_node("AnimationPlayer").get_current_animation()
	if player.velocity.x != 0:
		is_right = (player.velocity.x > 0)  # Atualiza is_right baseado no movimento
	
	# Define a direção do tiro (usa a última direção se estiver parado)
	if is_right:
		slash_anim.rotation_degrees = 90.0
		bullet.direction = Vector2.RIGHT
	else:
		slash_anim.rotation_degrees = -90.0
		bullet.direction = Vector2.LEFT
	bullet.global_position = muzzle.global_position
	bullets_fired += 1
	if bullets_fired < amount:
		get_tree().create_timer(fire_delay).timeout.connect(_fire_next_bullet)
func _on_cool_down_timeout() -> void:
	ativar()

func _on_time_alive_timeout() -> void:
	pass

func aumentar_dano():
	print(damage)
	damage += 5

func aumentar_tiros():
	amount += 1

func aumentar_range():
	pass

func aumentar_rate():
	cooldown.wait_time -= 0.1

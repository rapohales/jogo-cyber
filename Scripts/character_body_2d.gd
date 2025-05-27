extends CharacterBody2D

const speed = 200

@export var health = 100
@onready var animation_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var sprite = $AnimatedSprite2D
var can_take_damage := true
var invulnerability_time := 1
@onready  var vida_ui = $VidaDisplay/HealthBar


@onready var state_machine = anim_tree.get("parameters/playback")

var input_direction = null
var dekt = null
@export var start_direction : Vector2 = Vector2(0, 1)
func _ready() -> void:
	update_animation(start_direction)

# FUNÇÃO QUE ATIVA QUANDO INIMIGO ENCOSTA NELE.
		
func tomar_dano(dano):
	if not can_take_damage:
		return
	vida_ui.value -= dano
	health -= dano
	flash()
	if health <=0: ## SE VIDA MENOR QUE 0, ATVA A FUNÇÃO DE BAIXO.
		morrer()

# SE A VIDA FICAR MENOR QUE 0, ATIVA A FUNÇÃO MORRER
func morrer():
	print("Morreu")
	queue_free() ## DELETA ELE
	pass
func pegar_input():
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction.normalized() * speed
	
	
# FUNÇOES DE MOVIMENTO, IGNORAR.
func _physics_process(_delta: float) -> void:
	pegar_input()
	move_and_slide() 
	update_animation(input_direction)
	estado_animacao()

## AO TOMAR DANO, ATIVA O NEGOCIO VERMELHO NO SPRITE
func flash():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(2, 0.5, 0.5), 0.1)
	# Volta para a cor normal
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.3)


func update_animation(move_input: Vector2):
	if(move_input != Vector2.ZERO):
		anim_tree.set("parameters/idle/blend_position", move_input)
		anim_tree.set("parameters/walk/blend_position", move_input)

func estado_animacao():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")


func _on_vul_timer_timeout() -> void:
	can_take_damage = true

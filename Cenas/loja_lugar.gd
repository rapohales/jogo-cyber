extends Area2D


@onready var interactable: Area2D = $Interactables
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var lojaUI = $Loja
var open: bool = true

func _ready() -> void:
	EventBus.event_triggered.connect(_on_event)

func _on_event(event_name: String, _data: Variant):
	print(_data)
	if _data == "Loja_lugar" and open == true:
		_on_interact()
func _on_interact():
	if lojaUI.get_node("TextureRect").visible != true:
		lojaUI.get_node("TextureRect").visible = true
	else:
		lojaUI.get_node("TextureRect").visible = false


func _on_tempo_aberta_timeout() -> void:
	open = false
	$TempoFechada.start()
	sprite_2d.play("Closing")

func _on_tempo_fechada_timeout() -> void:
	$TempoFechada.stop()
	if $TempoFechada.is_stopped():
		open = true
		$TempoAberta.start()
		sprite_2d.play("Opening")

func _on_animated_sprite_2d_animation_finished() -> void:
	if open == true:
		sprite_2d.play("Idle")
		

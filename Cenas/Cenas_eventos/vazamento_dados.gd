extends Node2D
@export var cena_evento = preload("res://Cenas/InterfaceEvento.tscn")
@onready var player = get_node("../../Player")
var is_happening = false

func _ready() -> void:	
	if player != null && is_happening == false:
		
		is_happening = true
		var cena_dois = cena_evento.instantiate()
		add_child(cena_dois)
		var painel = cena_dois.get_node("Panel")
		var sprite = cena_dois.get_node("Sprite2D")
		var label = cena_dois.get_node("Label")
		var tween = create_tween()
		tween.tween_property(painel, "modulate:a", 1.0, 0.3)
		tween.tween_property(sprite, "modulate:a", 1.0, 0.3)
		tween.tween_property(label, "modulate:a", 1.0, 0.3)
		tween.tween_property(painel, "modulate:a", 0.0, 0.3)
		tween.tween_property(sprite, "modulate:a", 0.0, 0.3)
		tween.tween_property(label, "modulate:a", 0.0, 0.3)
		$Timer.start()
		$Cooldown.start()

func _on_timer_timeout() -> void:
	player.tomar_dano(1)
	
func _on_cooldown_timeout() -> void:
	is_happening = false

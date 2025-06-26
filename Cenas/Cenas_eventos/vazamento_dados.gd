extends Node2D
@export var cena_evento = preload("res://Cenas/InterfaceEvento.tscn")
@onready var player = get_node("../../Player")

func _ready() -> void:	

	if player != null:
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

func _on_timer_timeout() -> void:
	print("bobao", player.health)
	
	player.tomar_dano(1)
	

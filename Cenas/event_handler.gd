extends Node
@export var cada_evento: Array[PackedScene]
func _ready() -> void:
	EventBus.acontecer_evento.connect(rodar_evento)
	pass

func rodar_evento():
	var rng_evento = randi() % cada_evento.size()
	var evento_escolhido = cada_evento[rng_evento]
	var cena_um = evento_escolhido.instantiate()
	add_child(cena_um)
	pass
	
	
	

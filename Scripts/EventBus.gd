extends Node

signal event_triggered(event_name: String, data: Variant)
signal atualizar_score_eventbus(score: int, seguranca: int)

func emitir_ui(event_name: String, data = null) -> void:
	event_triggered.emit(event_name, data)
	print("Emitido")
	
func atualizar_score(score :int, seguranca: int) -> void:
	atualizar_score_eventbus.emit(score, seguranca)
	print("Emitiu o score")
	

	

extends Node

signal event_triggered(event_name: String, data: Variant)

func emitir_ui(event_name: String, data = null) -> void:
	event_triggered.emit(event_name, data)
	print("Emitido")
func atualizar_score(event_name: String, data :int) -> void:
	event_triggered.emit(event_name, data)
	print("Emitiu o score")
	

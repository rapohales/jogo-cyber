extends Node

signal event_triggered(event_name: String, data: Variant)
signal atualizar_score_eventbus(score: int, seguranca: int)
signal atualizar_score_out(score: int, seguranca: int)
signal atualizar_ui_progressbar(cur_xp, cur_lvl)

func _atualizar_ui_progressbar(cur_xp, cur_lvl):
	atualizar_ui_progressbar.emit(cur_xp, cur_lvl)
	print("oie")
	pass

func emitir_ui(event_name: String, data = null) -> void:
	event_triggered.emit(event_name, data)
	
func atualizar_score(score :int, seguranca) -> void:
	print("pinto")
	atualizar_score_out.emit(score, seguranca)
	
	

	

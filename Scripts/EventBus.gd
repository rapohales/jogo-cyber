extends Node

signal event_triggered(event_name: String, data: Variant)
signal atualizar_score_eventbus(score: int, seguranca: int)
signal atualizar_score_out(score: int, seguranca: int)
signal atualizar_ui_progressbar(cur_xp, cur_lvl)
signal darDanoPlayer(dano, nomeSinal)
signal atualizar_ui_reset_progressbar(cur_xp, next_level)



func _atualizar_ui_reset_progressbar(cur_xp, next_level):
	atualizar_ui_reset_progressbar.emit(cur_xp, next_level)


func _atualizar_ui_progressbar(cur_xp, cur_lvl, next_level):
	atualizar_ui_progressbar.emit(cur_xp, cur_lvl, next_level)
	print("oie")
	pass

func _darDanoPlayer(dano, nomeSinal):
	darDanoPlayer.emit(dano, nomeSinal)


func emitir_ui(event_name: String, data = null) -> void:
	event_triggered.emit(event_name, data)
	
func atualizar_score(score :int, seguranca) -> void:
	atualizar_score_out.emit(score, seguranca)
	
signal atualizar_esquivas(current_charges, max_charges)

	

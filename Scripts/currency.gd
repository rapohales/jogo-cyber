extends Node

signal evento_ocorreu

@export var moedas: int = 0
@export var seguranca: int = 0
@onready var UI_node = $"../Ui"
signal get_seguranca(seg)
func _on_coin_timer_timeout() -> void:
	moedas += 1;
	UI_node.update_score_display(moedas, seguranca)


func update_score_ui(score, _seguranca):
	EventBus.atualizar_score(score, _seguranca)
	
func _on_questions_onbotao_1_down(_moedas: Variant, _seguranca: Variant) -> void:
	moedas += _moedas
	seguranca += _seguranca
	update_score_ui(_moedas, _seguranca)
func _on_questions_onbotao_2_down(_moedas: Variant, _seguranca: Variant) -> void:
	moedas += _moedas
	seguranca += _seguranca
	print("Seguranca:", seguranca)
	print("aa")
	update_score_ui(_moedas, _seguranca)
	Main.att_vulnerabilidade(seguranca)
	

func chance_event_happen():
	if randf_range(0, 5) <= Main.vulnerabilidade_ativa * 0.1:
		evento_ocorreu.emit()
		var tween = create_tween()
		tween.tween_property(Engine, "time_scale", 0.2, 0.7).set_trans(Tween.TRANS_SINE)
		tween.tween_property(Engine, "time_scale", 1.0, 1.0)
		print("passou ein", Main.vulnerabilidade_ativa * 0.1)
	pass


func _on_chance_event_timeout() -> void:
	print("done")
	chance_event_happen()

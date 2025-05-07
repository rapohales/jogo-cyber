extends Node

@export var moedas: int = 0
@export var seguranca: int = 0
@onready var UI_node = $"../Ui"

func _on_coin_timer_timeout() -> void:
	moedas += 1;
	UI_node.update_score_display(moedas, seguranca)


func update_score_ui(score, _seguranca):
	EventBus.atualizar_score(score, seguranca )

func _on_questions_onbotao_1_down(_moedas: Variant, _seguranca: Variant) -> void:
	update_score_ui(moedas, seguranca)

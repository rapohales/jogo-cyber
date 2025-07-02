extends Node

var current_xp := 0
var current_level := 1
var xp_to_next_level := 100# XP necessário para o nível 2
var next_threshold;
signal nivel_att(cur_xp)
# Dicionário com os thresholds de XP para cada nível
# Ou uma fórmula para calcular dinamicamente
var xp_thresholds = {
	1: 0,     # Nível 1 (base)
	2: 100,   # Nível 2
	3: 250,   # Nível 3
	4: 450,
	5: 700,
	6: 1000,
	7: 1400,
	8: 1400,
	9: 1500,
	10: 1500,
	11: 1500,
	12: 1600,
	13: 1700,
	14: 1800,
	15: 1800,
	16: 1800,
	17: 1900,
	18: 2000,
	19: 2000,
	20: 2000,
	21: 2000,
	22: 2000,
	23: 2300,
	24: 2400,
	25: 2400,
	
	   
}
	
func add_xp(amount: int):
	current_xp += amount
	check_level_up()
	EventBus._atualizar_ui_progressbar(current_xp, current_level, xp_to_next_level)
func check_level_up():
	while current_xp >= get_xp_required_for_level(current_level + 1):
		level_up()

func get_xp_required_for_level(level):
	if xp_thresholds.has(level):
		return xp_thresholds[level]
		
func level_up():
	current_level += 1
	current_xp = 0
	Main.vul_por_nivel(current_level)
	
	var previous_threshold = get_xp_required_for_level(current_level - 1)
	next_threshold = get_xp_required_for_level(current_level)
	xp_to_next_level = next_threshold
	var farofa = xp_thresholds.get(current_level + 1, 0)
	EventBus._atualizar_ui_reset_progressbar(current_xp, farofa)
	var niveis_questao: Array = [3, 5, 7, 10, 12, 14, 17, 19, 20, 21, 22, 24, 26, 27, 28, 29,30]
	for i in niveis_questao.size():
		if current_level == niveis_questao[i]:
			EventBus.emitir_ui("emitir_ui", "´pmtps")


func _on_inimigo_morreu(valor) -> void:
	add_xp(valor)	 

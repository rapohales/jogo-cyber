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
	8: 2000,
	9: 2500,
	10: 3500,
	11: 4600,
	12: 5300,
	13: 450,
	14: 450,
	15: 450,
	16: 450,
	17: 450,
	18: 450,
	19: 450,
	20: 450,
	21: 450,
	22: 450,
	23: 450,
	24: 450,
	25: 450,
	
	   
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
	nivel_att.emit(current_level)
	current_level += 1
	current_xp = 0
	var previous_threshold = get_xp_required_for_level(current_level - 1)
	next_threshold = get_xp_required_for_level(current_level)
	xp_to_next_level = next_threshold
	var farofa = xp_thresholds.get(current_level + 1, 0)
	EventBus._atualizar_ui_reset_progressbar(current_xp, farofa)
	if current_level == 3 or current_level == 7 or current_level == 10 or current_level == 15:
		EventBus.emitir_ui("emitir_ui", "´pmtps")
		pass


func _on_inimigo_morreu(valor) -> void:
	add_xp(valor)	 

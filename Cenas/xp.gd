extends Node

var current_xp := 0
var current_level := 1
var xp_to_next_level := 100  # XP necessário para o nível 2
	
	
# Dicionário com os thresholds de XP para cada nível
# Ou uma fórmula para calcular dinamicamente
var xp_thresholds = {
	1: 0,     # Nível 1 (base)
	2: 100,   # Nível 2
	3: 250,   # Nível 3
	4: 450,   # E assim por diante...
	# Ou use uma fórmula progressiva
}

# Alternativa: calcular thresholds com fórmula
func calculate_xp_for_level(level):
	return pow(level, 2) * 100  # Exemplo: fórmula quadrática
	
func add_xp(amount: int):
	current_xp += amount
	check_level_up()
	EventBus._atualizar_ui_progressbar(current_xp, current_level)
func check_level_up():
	# Verifica se o jogador subiu de nível
	while current_xp >= get_xp_required_for_level(current_level + 1):
		level_up()

func get_xp_required_for_level(level):
	# Se estiver usando o dicionário
	if xp_thresholds.has(level):
		return xp_thresholds[level]
	# Se estiver usando fórmula
	return calculate_xp_for_level(level - 1)

func level_up():
	current_level += 1
	var previous_threshold = get_xp_required_for_level(current_level - 1)
	var next_threshold = get_xp_required_for_level(current_level)
	xp_to_next_level = next_threshold - previous_threshold
	
	# Emitir sinal ou chamar função quando subir de nível
	
	emit_signal("level_up", current_level, current_xp)
	
	# Atualizar UI ou outros sistemas
	# GameEvents.player_leveled_up.emit(current_level)


func _on_inimigo_morreu(valor) -> void:
	add_xp(valor)	 

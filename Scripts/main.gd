extends Node2D

@onready var currency = $Currency
func _ready() -> void:
	$Coin_timer.start()

@export var vulnerabilidade: float = 1;
func _on_xp_2_nivel_att(nivel) -> void:
	vulnerabilidade = ((nivel / 0.7) + vulnerabilidade - (vulnerabilidade * 0.2))
	print("nivel: %d" % nivel)
	print("vul: %f" % vulnerabilidade)
	pass

extends Node2D

@onready var currency = $Currency
func _ready() -> void:
	$Coin_timer.start()
	

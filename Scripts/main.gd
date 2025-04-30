extends Node2D

@export var score: int = 0;


func _ready() -> void:
	$Coin_timer.start()
	$Ui.update_score_display(score)
	
	
func _on_coin_timer_timeout() -> void:
	print("uuu")
	score += 1;
	$Ui.update_score_display(score)
	pass 

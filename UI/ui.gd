extends CanvasLayer

@onready var score_label = $ScoreLabel

func _ready() -> void:
	EventBus.atualizar_score_eventbus.connect(update_score_display)
	


func update_score_display(score, seguranca):
	
	score_label.text = "Coins: %d" % score
	

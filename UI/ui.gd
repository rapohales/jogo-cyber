extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var score_label2 = $ScoreLabel2

func _ready() -> void:
	EventBus.atualizar_score_eventbus.connect(update_score_display)
	
func update_score_display(score, _seguranca):
	score_label.text = "Coins: %d" % score
	score_label2.text = "Segurança %d" % _seguranca

func update_score_out(score, seguranca):
	EventBus.atualizar_score_out.connect(update_score_display)
	print(score)
	
	


	

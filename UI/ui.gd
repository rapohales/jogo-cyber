extends CanvasLayer

@onready var score_label = $ScoreLabel

func update_score_display(score):
	score_label.text = "Coins: %d" % score
	

extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var score_label2 = $ScoreLabel2
@onready var progressbar = $TextureProgressBar

func _ready() -> void:
	EventBus.atualizar_score_eventbus.connect(update_score_display)
	EventBus.atualizar_ui_progressbar.connect(update_progressbar_display)
	
func update_progressbar_display(cur_xp, cur_lvl):
	progressbar.value = cur_xp
	print(cur_lvl)
	pass
func update_score_display(score, _seguranca):
	score_label.text = "Coins: %d" % score
	score_label2.text = "Segurança %d" % _seguranca

func update_score_out(score, _seguranca):
	EventBus.atualizar_score_out.connect(update_score_display)
	print(score)
	
	


	

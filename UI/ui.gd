extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var score_label2 = $ScoreLabel2
@onready var score_label3 = $ScoreLabel3
@onready var progressbar = $TextureProgressBar
@onready var fireworks_scene = preload("res://Cenas/efeito_nivel.tscn")

func _ready() -> void:
	EventBus.atualizar_score_eventbus.connect(update_score_display)
	EventBus.atualizar_ui_progressbar.connect(update_progressbar_display)
	EventBus.atualizar_ui_reset_progressbar.connect(reset_progressbar_display)

func reset_progressbar_display(cur_xp, next_level):
	progressbar.value = 0
	progressbar.max_value = next_level
	var fireworks = fireworks_scene.instantiate()
	fireworks.position = $Marker2D.global_position
	add_child(fireworks)
	
	fireworks.emitting = true

	
	await get_tree().create_timer(2.0).timeout
	fireworks.queue_free()
	print("pege %d" % progressbar.max_value)

func update_progressbar_display(cur_xp, cur_lvl, next_level):
	print("iidi %d" % cur_xp)
	progressbar.value = cur_xp
	score_label3.text = "Nível: %d" %cur_lvl
	pass
func update_score_display(score, _seguranca):
	score_label.text = "Coins: %d" % score
	score_label2.text = "Segurança %d" % _seguranca

func update_score_out(score, _seguranca):
	EventBus.atualizar_score_out.connect(update_score_display)
	print(score)
	
	


	

extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var score_label2 = $ScoreLabel2
@onready var score_label3 = $ScoreLabel3
@onready var progressbar = $TextureProgressBar
@onready var fireworks_scene = preload("res://Cenas/efeito_nivel.tscn")
var dodge_label = Label.new()

func _ready() -> void:
	_setup_dodge_label()
	EventBus.atualizar_esquivas.connect(update_dodge_display)
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

func update_progressbar_display(cur_xp, cur_lvl, next_level):
	progressbar.value = cur_xp
	score_label3.text = "Nível: %d" %cur_lvl
	pass

func _setup_dodge_label():
	dodge_label.name = "DodgeLabel"
	dodge_label.text = "Esquivas: 3/3"
	dodge_label.position = Vector2(20, 100)
	dodge_label.add_theme_font_size_override("font_size", 24)
	add_child(dodge_label)

func update_dodge_display(current: int, max_charges: int):
	dodge_label.text = "Esquivas: %d/%d" % [current, max_charges]

func update_score_display(score, _seguranca, mult):
	score_label.text = "Coins: %d" % score 
	score_label2.text = "Segurança %d" % _seguranca
	score_label.get_node("ScoreLabel").text = "Mult: %d" % mult

func update_score_out(score, _seguranca):
	EventBus.atualizar_score_out.connect(update_score_display)
	print(score)

extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var score_label2 = $ScoreLabel2
@onready var progressbar = $TextureProgressBar
var dodge_label = Label.new()  # Criaremos o Label programaticamente

func _ready() -> void:
	# Configuração do Label de esquivas
	_setup_dodge_label()
	
	# Conexões originais
	EventBus.atualizar_score_eventbus.connect(update_score_display)
	EventBus.atualizar_ui_progressbar.connect(update_progressbar_display)
	EventBus.atualizar_esquivas.connect(update_dodge_display)

func _setup_dodge_label():
	dodge_label.name = "DodgeLabel"
	dodge_label.text = "Esquivas: 3/3"
	dodge_label.position = Vector2(20, 100)  # Posição ajustável
	dodge_label.add_theme_font_size_override("font_size", 24)
	add_child(dodge_label)

func update_dodge_display(current: int, max_charges: int):
	dodge_label.text = "Esquivas: %d/%d" % [current, max_charges]

func update_progressbar_display(cur_xp, cur_lvl):
	progressbar.value = cur_xp
	print(cur_lvl)

func update_score_display(score, _seguranca):
	score_label.text = "Coins: %d" % score
	score_label2.text = "Segurança %d" % _seguranca

func update_score_out(score, _seguranca):
	EventBus.atualizar_score_out.connect(update_score_display)
	print(score)

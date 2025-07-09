extends CanvasLayer
@export var perguntas: Array[Pergunta] = []
@onready var op1: TextureButton = $Button
@onready var op2: TextureButton = $Button2
signal onbotao1down(moedas, segurança, mult)
signal onbotao2down(moedas, segurança, mult)
@onready var key1 = $TextureButton
@onready var key2 = $TextureButton2
@onready var box = $HBoxContainer
@onready var boxText = $HBoxContainer/Label
@onready var sprite = $Sprite2D
@onready var but1 = $Button
@onready var but2 = $Button2
@onready var text1 = $Button/Label
@onready var text2 = $Button2/Label

var pergunta_escolhida 
var pergunta_selecionada 

func _ready():
	print(perguntas[0].texto)
	EventBus.event_triggered.connect(_on_event)

func choose_questions_rand():
	pergunta_escolhida = randi() % perguntas.size()
	pergunta_selecionada = perguntas[pergunta_escolhida]
	boxText.text = pergunta_selecionada.texto
	text1.text = pergunta_selecionada.respostas[0]
	text2.text = pergunta_selecionada.respostas[1]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("botao2"):
		_on_button_button_down()
	if event.is_action_pressed("botao1"):
		_on_button_2_button_down()
	
func more_opacity():
	visible = true
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(Engine, "time_scale", 0.3, 0.4).set_trans(Tween.TRANS_SINE)
	tween.tween_property(box, "modulate:a", 1.0, 0.3)
	tween.tween_property(sprite, "modulate:a", 1.0, 0.3)
	tween.tween_property(but1, "modulate:a", 1.0, 0.3)
	tween.tween_property(but2, "modulate:a", 1.0, 0.3)
	tween.tween_property(key1, "modulate:a", 1.0, 0.3)
	tween.tween_property(key2, "modulate:a", 1.0, 0.3)


func less_opacity():
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(Engine, "time_scale", 1, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(box, "modulate:a", 0.0, 0.5)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5)
	tween.tween_property(but1, "modulate:a", 0.0, 0.5)
	tween.tween_property(but2, "modulate:a", 0.0, 0.5)
	tween.tween_property(key1, "modulate:a", 0.0, 0.5)
	tween.tween_property(key2, "modulate:a", 0.0, 0.5)
	
	
func _on_event(event_name: String, _data: Variant):
	if event_name == "emitir_ui" and _data == "Chest": 
		choose_questions_rand()
		more_opacity()
		get_canvas()

func _on_button_button_down() -> void:
	onbotao1down.emit(pergunta_selecionada.r1_dinheiro, pergunta_selecionada.r1_seguranca, pergunta_selecionada.r1_mult)
	less_opacity()



func _on_button_2_button_down() -> void:
	onbotao2down.emit(pergunta_selecionada.r2_dinheiro, pergunta_selecionada.r2_seguranca, pergunta_selecionada.r2_mult)
	less_opacity()

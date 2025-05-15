extends CanvasLayer

@onready var op1: Button = $VBoxContainer/HBoxContainer/Button
@onready var op2: Button = $VBoxContainer/HBoxContainer/Button2
signal onbotao1down(moedas, segurança)
signal onbotao2down(moedas, segurança)
signal temp_dano_inimigo(dano)
func _ready():
	EventBus.event_triggered.connect(_on_event)
	
func _on_event(event_name: String, _data: Variant):
	if event_name == "emitir_ui": 
		get_canvas()
		visible = true
		
	

func _on_button_button_down() -> void:
	onbotao1down.emit(50, 0)
func _on_button_2_button_down() -> void:
	onbotao2down.emit(-50, 2)
	temp_dano_inimigo.emit(10)

	

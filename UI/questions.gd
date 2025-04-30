extends CanvasLayer

@onready var op1: Button = $VBoxContainer/HBoxContainer/Button
@onready var op2: Button = $VBoxContainer/HBoxContainer/Button2

func _ready():
	EventBus.event_triggered.connect(_on_event)
	
func _on_event(event_name: String, _data: Variant):
	if event_name == "emitir_ui": 
		get_canvas()
		visible = true
		
	
func _on_button_button_down() -> void:
	visible = false
	
func _on_button_2_button_down() -> void:
	visible = false

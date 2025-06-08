extends Control

@onready var resume_button: Button = $PanelContainer/VBoxContainer/Button
@onready var restart_button: Button = $PanelContainer/VBoxContainer/Button2
@onready var quit_button: Button = $PanelContainer/VBoxContainer/Button3

func _ready():
	resume_button.pressed.connect(_on_resume_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		resume()
	else:
		pause()

func pause():
	get_tree().paused = true
	visible = true

func resume():
	get_tree().paused = false
	visible = false

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

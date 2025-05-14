extends Node2D

var bar_red = preload("res://Assets/Vida_bar/healthbar4.png")
var bar_blue = preload("res://Assets/Vida_bar/healthbar1.png")
var bar_yellow = preload("res://Assets/Vida_bar/healthbar2.png")

@onready var healthbar = $HealthBar

func _ready():
	if get_parent() and get_parent().get("max_health"):
		print("lala")
		healthbar.max_value = get_parent().max_health

func update_healthbar(value):
	healthbar.texture_progress = bar_blue
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		healthbar.value = value

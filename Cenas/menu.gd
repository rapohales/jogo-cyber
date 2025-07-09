extends Control

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	
func _on_bot_play_pressed() -> void:
	var transition = get_tree().create_tween()
	transition.tween_property(self, "modulate:a", 0, 0.5)
	await transition.finished
	$AudioStreamPlayer2D.stop()
	get_tree().change_scene_to_file("res://Cenas/Mundo.tscn")

extends Area2D

@export var speed = 100


var direction = Vector2.RIGHT  
func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()
func _on_body_entered(body) -> void:
	var player = get_tree().get_first_node_in_group("player")
	
	var espada = player.get_node("Espada")
	var dano = espada.damage
	if body.is_in_group("enemies"):
		body.tomarDano(dano)

extends Area2D

@export var speed = 100
var direction = Vector2.RIGHT  


func _ready():
	$VisibilityNotifier2D.screen_exited.connect(_on_screen_exited)
	if not has_node("CollisionPolygon2D"):
		return
func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()
func _on_body_entered(body) -> void:
	if body.is_in_group("enemies"):
		body.tomarDano(30)

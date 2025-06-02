extends Node2D

@export var damage = 40
@export var amount = 1
@export var speed = 500

@onready var hitbox = $Slash/CollisionPolygon2D
@onready var sprite = $Slash/SlashSprite
var direction = Vector2.ZERO



func ativar():
	$Slash.visible = true
	print("Atirou")
	await get_tree().create_timer(2.0).timeout
	$Slash.visible = false
func _on_cool_down_timeout() -> void:
	ativar()

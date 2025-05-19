extends Marker2D

@export var enemy_scene: PackedScene  
@export var max_enemies := 2
@export var spawn_delay := 5.0

var _timer := 0.0

func _ready():
	# Tenta carregar automaticamente se não estiver configurado
	if enemy_scene == null:
		enemy_scene = load("res://Cenas/inimigo.tscn")  # Caminho exato do seu arquivo
		if enemy_scene == null:
			push_error("❌ Cena do inimigo não encontrada em res://inimigo.tscn")
		else:
			print("✅ Cena do inimigo carregada automaticamente")

func _process(delta):
	if enemy_scene == null:
		return
	
	_timer += delta
	if _timer >= spawn_delay and get_child_count() < max_enemies:
		_timer = 0.0
		var new_enemy = enemy_scene.instantiate()
		add_child(new_enemy)
		new_enemy.global_position = global_position

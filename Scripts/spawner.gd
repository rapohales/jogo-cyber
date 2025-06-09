extends Marker2D

# Configurações do spawner
@export var enemy_scenes: Array[PackedScene] = []
@export var max_enemies := 999
@export var min_delay = 1
@export var max_delay = 1.3
var spawn_delay: float = randf_range(max_delay, min_delay) + min_delay
@export var spawn_radius: float = 50.0

# Texturas para a barra de vida (adicionado conforme seu código)
var bar_red = preload("res://Assets/Vida_bar/healthbar4.png")
var bar_blue = preload("res://Assets/Vida_bar/healthbar1.png")
var bar_yellow = preload("res://Assets/Vida_bar/healthbar2.png")

var _timer := 0.0

func _ready():
	# Carrega inimigos padrão se não estiverem configurados
	if enemy_scenes.is_empty():
		load_default_enemies()
	
	# Debug
	print("Spawner iniciado com ", enemy_scenes.size(), " tipos de inimigos")

func _process(delta):
	if enemy_scenes.is_empty():
		return
	
	_timer += delta
	if _timer >= spawn_delay and get_child_count() < max_enemies:
		_timer = 0.0
		spawn_random_enemy()

func load_default_enemies():
	var default_enemies = [
		"res://Cenas/inimigo.tscn",
		"res://Cenas/inimigo2.tscn",
		"res://Cenas/inimigo3.tscn"
	]
	
	for path in default_enemies:
		var enemy = load(path)
		if enemy:
			enemy_scenes.append(enemy)
			print("✅ Carregado: ", path)
		else:
			push_error("❌ Falha ao carregar: ", path)

func spawn_random_enemy():
	var selected_scene = enemy_scenes[randi() % enemy_scenes.size()]
	var new_enemy = selected_scene.instantiate()
	
	var main_node = get_tree().root.get_node("Mundo")  # Ajuste o caminho conforme sua estrutura
	main_node.add_child(new_enemy)
	# Posiciona o inimigo
	var spawn_pos = global_position
	if spawn_radius > 0:
		var angle = randf() * TAU
		spawn_pos += Vector2(cos(angle), sin(angle)) * randf() * spawn_radius
	

	new_enemy.global_position = spawn_pos
	# Configura a barra de vida do inimigo
	setup_enemy_healthbar(new_enemy)
	
	print("🔼 Spawned: ", new_enemy.name, " at ", spawn_pos)

func setup_enemy_healthbar(enemy):
	# Verifica se o inimigo tem um nó HealthBar
	if enemy.has_node("HealthBar"):
		var healthbar = enemy.get_node("HealthBar")
		
		# Conecta o sinal de mudança de vida se existir
		if enemy.has_signal("health_changed"):
			enemy.connect("health_changed", Callable(self, "_on_enemy_health_changed").bind(healthbar))
		
		# Configura valores iniciais
		if enemy.has_method("get_max_health"):
			healthbar.max_value = enemy.get_max_health()
			healthbar.value = healthbar.max_value
			healthbar.texture_progress = bar_blue
		
		# Adiciona script dinâmico para atualização da barra
		add_healthbar_script(healthbar)

func add_healthbar_script(healthbar):
	# Adiciona funcionalidade dinâmica à barra de vida
	healthbar.set_script(preload("res://Scripts/vida_display.gd"))
	healthbar.bar_red = bar_red
	healthbar.bar_blue = bar_blue
	healthbar.bar_yellow = bar_yellow

func _on_enemy_health_changed(new_health, healthbar):
	# Atualiza a aparência da barra conforme a vida atual
	healthbar.value = new_health
	
	if new_health < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	elif new_health < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	else:
		healthbar.texture_progress = bar_blue

class_name Upgrade extends Resource

@export var id: int;
@export var nome: String;
@export var description: String;
@export var arma: bool;
@export var preco: int;
@export var metodo: String;
@export var alvo_nome: String;

func aplicar_funcao(alvo: Node):
	print(alvo)
	print("teste")
	if alvo.has_method(metodo):
		alvo.call(metodo)
		print("aloo")
	else:
		print("naooo")
	

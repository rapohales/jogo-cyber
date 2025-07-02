class_name Upgrade extends Resource

@export var id: int;
@export var nome: String;
@export var description: String;
@export var Arma: String;
@export var preco: int;
@export var metodo: String;

func aplicar_funcao(alvo: Node):
	print("teste")
	if alvo.has_method(metodo):
		alvo.call(metodo)
		print("aloo")
	else:
		print("naooo")
	

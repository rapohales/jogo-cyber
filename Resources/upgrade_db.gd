class_name UpgradeDb extends Resource

@export var upgrades: Array[Upgrade] = []

func achar_id_funcao(id_procurado: int) -> Upgrade:
	for i in upgrades:
		if i.id == id_procurado:
			return i
	return null
	

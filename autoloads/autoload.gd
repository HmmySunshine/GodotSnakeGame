extends Node

const GROBAL_SIZE:int = 32
#初始化数据
var save_data:SaveData

func _ready():
	save_data = SaveData.load_or_create()

class_name SaveData extends Resource

@export var high_score:int = 0
#保存文件的相对路径
#user:// 是一个相对路径，相对于用户的个人数据目录。这意味着无论游戏在哪个平台上运行，Godot 都会自动将 user:// 转换为该平台上的适当路径。
const SAVE_PATH:String = "user://sean_high_score_emporium.tres"

func save() -> void:
	ResourceSaver.save(self,SAVE_PATH)

static func load_or_create() -> SaveData:
	var save_data:SaveData
	if FileAccess.file_exists(SAVE_PATH):
		save_data = load(SAVE_PATH) as SaveData
	else:
		save_data = SaveData.new()
		
	return save_data

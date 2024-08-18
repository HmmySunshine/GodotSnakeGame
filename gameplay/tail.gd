class_name Tail extends SnakePart

@export var textures:Array[Texture]
@onready var sprite_2d = $Sprite2D

func _ready():
	#从目标数组中返回一个随机值。如果数组为空，则打印一个错误并返回 null
	sprite_2d.texture = textures.pick_random()

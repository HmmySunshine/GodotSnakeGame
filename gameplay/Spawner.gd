class_name Spanwer extends Node

#信号可以档函数使
signal tail_added(tail:Tail)

@export var bounds:Bounds
#二种方式
const FOOD = preload("res://gameplay/food.tscn")
var tail_scene:PackedScene = preload("res://gameplay/tail.tscn")

#生成食物
func spawn_food():
	#需要一个
	var food_pos:Vector2 = Vector2.ZERO
	food_pos.x = randf_range(bounds.x_min + Autoload.GROBAL_SIZE, bounds.x_max - Autoload.GROBAL_SIZE)
	food_pos.y = randf_range(bounds.y_min + Autoload.GROBAL_SIZE, bounds.y_max - Autoload.GROBAL_SIZE)
	food_pos.x = floorf(food_pos.x / Autoload.GROBAL_SIZE) * Autoload.GROBAL_SIZE
	food_pos.y = floorf(food_pos.y / Autoload.GROBAL_SIZE) * Autoload.GROBAL_SIZE

	var food = FOOD.instantiate()
	food.position = food_pos
	self.get_parent().add_child(food)


func spawn_tail(pos:Vector2):
	var tail:Tail = tail_scene.instantiate() as Tail
	tail.position = pos
	self.get_parent().add_child(tail)
	tail_added.emit(tail)

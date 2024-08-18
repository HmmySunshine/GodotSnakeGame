class_name Gameplay extends Node2D

const GAMEOVER_SCENCE = preload("res://menu/game_over.tscn")
const PAUSE_MENU = preload("res://menu/pause_menu.tscn")
const UI_SCORE = preload("res://menu/score_ui.tscn")

@onready var head:Head = $Head
@onready var bounds:Bounds = $Bounds
@onready var spanwer:Spanwer = $Spawner

var game_menu:UiGameOver
var game_pause:UIPauseMenu
var ui_score:UiScore

#大概一秒更新一次蛇的位置
var time_between_moves:float = 1000
var time_since_last_move:float = 0 
#(1,0)
var move_dir:Vector2 = Vector2.RIGHT
var speed:float = 5000
var snake_parts:Array[SnakePart] = []
#分数的getset
var score:int:
	get:
		return score
	set(value):
		score = value
		ui_score.set_scoreui(score)
		
		

func _ready():
	head.food_eaten.connect(_on_food_eaten)
	head.collided_with_tail.connect(_on_tail_collided)
	spanwer.tail_added.connect(_on_tail_added)
	spanwer.spawn_food()
	snake_parts.push_back(head)
	#初始化分数ui
	create_scoreui()
	

func  _process(_delta):
	var new_dir:Vector2 = Vector2.ZERO
	if Input.is_action_just_pressed("pause_button"):
		pause_menu()
	
	if Input.is_action_pressed("move_left"):
		new_dir = Vector2.LEFT
	elif Input.is_action_pressed("move_right"):
		new_dir = Vector2.RIGHT
	elif Input.is_action_pressed("move_up"):
		new_dir = Vector2.UP
	elif Input.is_action_pressed("move_down"):
		new_dir = Vector2.DOWN
	#玩家改变了方向但是不能改变逆向 s 不能再按w
	if move_dir + new_dir != Vector2.ZERO and new_dir != Vector2.ZERO:
		move_dir = new_dir

func update_snake():
	var new_position:Vector2 = head.position + move_dir * Autoload.GROBAL_SIZE
	#设置边界出界环绕
	new_position = bounds.wrap_vector(new_position)
	head.move_to(new_position)
	for i in range(1, snake_parts.size(), 1):
		snake_parts[i].move_to(snake_parts[i-1].last_position)
	
func _physics_process(delta):
	time_since_last_move += delta*speed
	#print(delta)
	if time_since_last_move >= time_between_moves:
		update_snake()
		time_since_last_move = 0
		
func _on_food_eaten():
	#使用call_deferred可以将操作推迟到当前帧结束时
	#这时所有的物理计算和其他过程已经完成，场景处于一个更稳定的状态，可以进行修改。
	print("food eaten")
	spanwer.call_deferred("spawn_food")
	spanwer.call_deferred("spawn_tail", snake_parts[snake_parts.size() - 1].last_position)
	score += 1
	#ui_score.set_scoreui(score)
	speed += 10
#您的描述是Godot中信号和槽（slot）机制的标准用法。
#当一个节点发出信号时，连接到该信号的任何方法都会被调用，并传递相应的参数。
func _on_tail_added(tail:Tail):
	snake_parts.push_back(tail)
	
func _on_tail_collided():
	print("game over")
	#如果ui不存在实例化场景ui
	if not game_menu:
		#实例化的结果转换为类型为 UiGameOver 的对象
		game_menu = GAMEOVER_SCENCE.instantiate() as UiGameOver
		add_child(game_menu)
		game_menu.set_score(score)
		
func pause_menu():
	if not game_pause:
		game_pause = PAUSE_MENU.instantiate()
		add_child(game_pause)
		
func create_scoreui():
	ui_score = UI_SCORE.instantiate() as UiScore
	add_child(ui_score)
	ui_score.set_scoreui(score)

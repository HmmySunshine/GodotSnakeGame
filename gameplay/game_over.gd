class_name UiGameOver extends CanvasLayer

@onready var score_label = %ScoreLabel
@onready var high_score_label = %HighScoreLabel
@onready var restart_button = %RestartButton
@onready var quit_button = %QuitButton


func set_score(score:int) ->void:
	score_label.text = "Final Score:" + str(score)
	#如果成绩比最高分高显示最高分
	if score > Autoload.save_data.high_score:
		Autoload.save_data.high_score = score
		Autoload.save_data.save()
		high_score_label.text = "New High Score:" + str(score)
		high_score_label.visible = true
	else:
		high_score_label.visible = false
		
func _on_restart_button_pressed() ->void:
	print("restart button pressed")
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	print("quit_button_pressed")
	get_tree().quit()


#有ui进入场景树场景暂停 记得ui进程设置一直进行
func _notification(what):
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false

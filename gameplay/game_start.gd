class_name UiGameStart extends CanvasLayer

const gameplay_scence = preload("res://gameplay/gameplay.tscn")

@onready var score_label = %ScoreLabel
@onready var start_button = %StartButton
@onready var quit_button = %QuitButton

func set_startsocre() ->void:
	var high_score = Autoload.save_data.high_score
	score_label.text = "High Score:" + str(high_score)
	
func _ready():
	set_startsocre()

#更换场景
func _on_start_button_pressed():
	get_tree().change_scene_to_packed(gameplay_scence)

func _on_quit_button_pressed():
	get_tree().quit()



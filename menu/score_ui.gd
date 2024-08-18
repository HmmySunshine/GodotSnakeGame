class_name UiScore extends CanvasLayer

@onready var score_label = %ScoreLabel
@onready var high_score_label = %HighScoreLabel

func _ready():
	high_score_label.text = "high score:" + str(Autoload.save_data.high_score)

func set_scoreui(score:int):
	score_label.text = "score:"+str(score)


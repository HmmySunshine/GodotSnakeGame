class_name UIPauseMenu extends CanvasLayer

@onready var resume_button = %ResumeButton
@onready var quit_button = %QuitButton

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("pause_button"):
		queue_free()

func _on_resume_button_pressed():
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().quit()

func _notification(what):
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false

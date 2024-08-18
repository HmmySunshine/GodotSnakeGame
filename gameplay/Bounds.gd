class_name Bounds extends Node

@onready var upper_left = $UpperLeft
@onready var lower_right = $LowerRight

var x_max:float
var x_min:float
var y_max:float
var y_min:float
# Called when the node enters the scene tree for the first time.
func _ready():
	x_max = lower_right.position.x
	x_min = upper_left.position.x
	y_max = lower_right.position.y
	y_min = upper_left.position.y

func wrap_vector(new_position:Vector2)->Vector2:
	if new_position.x > x_max:
		new_position.x = x_min
	elif new_position.x < x_min:
		new_position.x = x_max
	elif new_position.y > y_max:
		new_position.y = y_min
	elif new_position.y < y_min:
		new_position.y = y_max
	return new_position


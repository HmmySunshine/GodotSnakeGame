class_name Head extends SnakePart

signal food_eaten
signal collided_with_tail
func _on_area_entered(area):
	print(area.name)
	if area.is_in_group("food"):
		food_eaten.emit()
		#在帧操作完成删除
		area.call_deferred("queue_free")
	else:
		collided_with_tail.emit()
		

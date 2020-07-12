extends Node2D

class_name Tool

var mood = 100.0
var age = 0.0
var max_age = 100.0

func _ready() -> void:
	pass

func give_item_by_id(id: String):
	print("I got " + id)

func _change_mood(change: float) -> void:
	mood = clamp(mood + change, 0.0, 100.0)
	update_mood_display()

func get_mood() -> float:
	return mood
	
func update_mood_display() -> void:
	assert("unimplemented")

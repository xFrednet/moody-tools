extends Node2D

class_name Tool

var mood = 0
var age = 0
var max_age = 100

func _ready() -> void:
	pass

func give_item_by_id(id: String):
	print("I got " + id)

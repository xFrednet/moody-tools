extends Node2D

class_name ItemSpawn

export var id: String
export(int, 1, 100) var count: int = 1

func _ready() -> void:
	add_child(Item.new(id, count))
	call_deferred("remove_and_skip", self)

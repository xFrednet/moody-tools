extends Node2D

class_name Item

var id: String
var count: int

func _init(id: String, count: int) -> void:
	self.id = id
	self.count = count

func get_id() -> String:
	return id

func get_count() -> int:
	return count
	
func add(count: int) -> void:
	self.count += count

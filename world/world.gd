extends Node2D

func _init() -> void:
	GameData.world = self

func _ready() -> void:
	pass
	
func add_entity(entity):
	$enemies.add_child(entity)

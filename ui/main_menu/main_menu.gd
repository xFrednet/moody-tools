extends Control

onready var _ingame_scene = load("res://in_game.tscn")

func _ready() -> void:
	pass

func _on_exit_button_down() -> void:
	get_tree().quit()


func _on_start_button_down() -> void:
	var parent = get_parent()
	var game = _ingame_scene.instance()
	parent.add_child(game)
	parent.remove_child(self)

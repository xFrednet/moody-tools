extends Control

onready var _intro_scene = load("res://ui/intro/intro.tscn")

func _ready() -> void:
	pass

func _on_exit_button_down() -> void:
	get_tree().quit()


func _on_start_button_down() -> void:
	var parent = get_parent()
	var intro = _intro_scene.instance()
	parent.add_child(intro)
	parent.remove_child(self)

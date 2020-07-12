extends Control

signal continue_game

var _was_paused_game_released = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if (Input.is_action_just_released("pause_game")):
		_was_paused_game_released = true
	
	if (Input.is_action_just_pressed("pause_game") && _was_paused_game_released):
		continue_game()

func continue_game():
	set_visible(false)
	get_tree().paused = false
	emit_signal("continue_game")

func _on_continue_button_pressed() -> void:
	continue_game()

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_exit_button_visibility_changed() -> void:
	_was_paused_game_released = false

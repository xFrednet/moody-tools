extends Node


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("pause_game")):
		pause_game()

func pause_game():
	print("pause")
	get_tree().paused = true
	$ui/esc_menu.set_visible(true)

func _on_esc_menu_continue_game() -> void:
	print("unpause")
	get_tree().paused = false

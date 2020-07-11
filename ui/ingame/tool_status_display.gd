extends Control

func _ready() -> void:
	set_status("Hello World")
	set_mood(75)
	pass

func set_mood(mood: int) -> void:
	$mood_bar.set_value(mood)

func set_status(text: String) -> void:
	$status.set_text(text)
	$status.set_visible(true)
	$status/status_timer.start()

func _on_status_timer_timeout() -> void:
	$status.set_visible(false)

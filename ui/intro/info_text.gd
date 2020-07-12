extends Label

const INTRO_TEXT = [
	"Welcome new adventurer! I'm texti and also all that is left after you crashed our spaceship.",
	"Well done!!! You're the employee of the month.",
	"...",
	"So to leave this planet we have to find four scrap pieces.",
	"And with \"we\" I mean YOU :D",
	"No need to thank me ^^",
	"So let's get to it. You can find a pice of scrap in each cardinal direction, they should be reachable by following the paths.",
	"",
	"Wait before you start, we have a slight problem... Most of our equipment got destroyed. You will get our special tools:",
	"Karl: These boots control your movement, but I have to warn you. He might have a slight alcohol addiction. Just keep him happy and sover enough to walk and you should be finde.",
	"Frank: The hungry backpack, he is a trusty companian, if you keep him well fed.",
	"Now you should start your adventure. Come to me, when you have colleced the four scrab pieces"
]

onready var _ingame_scene = load("res://in_game.tscn")

var _next_display_index = 0

func _ready() -> void:
	_add_text()

func _on_into_text_timer_timeout() -> void:
	_add_text()

func _add_text() -> void:
	if (_next_display_index < INTRO_TEXT.size()):
		set_text(get_text() + INTRO_TEXT[_next_display_index] + "\n\n")
	elif (_next_display_index == INTRO_TEXT.size()):
		$skip_button.set_disabled(true)
		$start_button.set_disabled(false)
		$start_button/start_button_label.set_visible(true)
	
	_next_display_index += 1


func _on_skip_button_pressed() -> void:
	$into_text_timer.set_wait_time(0.01)
	$into_text_timer.start()

func _on_start_button_pressed() -> void:
	var parent = get_parent()
	var game = _ingame_scene.instance()
	parent.add_child(game)
	parent.remove_child(self)

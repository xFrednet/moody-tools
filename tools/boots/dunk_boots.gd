extends Boots

class_name DunkBoots

const BASE_SPEED = 6000
const ALC_MULTIPLIER = 2000
const AGE_MULTIPLIER = 3000
const MIN_ALC_LEVEL = 20
const DRUNK_MOTION_SPEED = 100

const random_quote = [
	"I drink to make other boots more interesting *cheers*",
	"I can stop when ever I wan't! Let's have a drink on that my friend",
	"I drink to make my owner more interesting",
	"What do we want to drink, well all of the things!!!!",
	"Voddi, is my life water"
]

var alc_level = 50.0
var delta = 0.0
var drunk_motion = Vector2(1.0, 0)

func _ready() -> void:
	_display_status("Hello my friend!\nFriends don't let friends drink alone, so drink something with me!")
	pass

func get_movement(delta: float) -> Vector2:
	var rot = 0
	var alc_sensation = (alc_level - MIN_ALC_LEVEL) / 100.0
	if alc_level > MIN_ALC_LEVEL:
		rot = sin(self.delta * 10)
	else:
		rot = sin(self.delta * 100) 
		
	var speed = get_speed(delta)
	var input_motion = get_movement_request().rotated(rot) * (speed)
	
	return input_motion + drunk_motion * DRUNK_MOTION_SPEED * alc_sensation

func _process(delta: float) -> void:
	self.delta += delta
	
	var b = 0.3
	drunk_motion.x = drunk_motion.x * (1 - b) + (randf() * 2 - 1) * b
	drunk_motion.y = drunk_motion.y * (1 - b) + (randf() * 2 - 1) * b
	drunk_motion = drunk_motion.normalized()

func get_speed(delta: float) -> float:
	var alc_sensation = (alc_level - MIN_ALC_LEVEL) / 100.0
	return (BASE_SPEED +
		ALC_MULTIPLIER * (alc_sensation * alc_sensation) +
		AGE_MULTIPLIER * ((max_age - age) / max_age)) * delta

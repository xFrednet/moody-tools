extends Boots

class_name DunkBoots

const BASE_SPEED = 2000
const ALC_MULTIPLIER = 4000
const MOOD_MULTIPLIER = 8000
const MIN_ALC_LEVEL = 20
const DRUNK_MOTION_SPEED = 1500

const GOT_ALCOKOL = [
	"Thank you, that's so tasty",
	"Hello bottle my old friend, I've come to talk to you again",
	"Alc is the best",
	"I love you my darling, you are the only bottle for me",
	"Keep it flowing",
	"More alc more fun!!! :3"
]
const UNUSABLE_ITEM = [
	"Take that away, I can't drink that!!!!",
	"There is no alcohol inside :/",
	"That is disgusting",
	"Eat what you want, but I only want alcohol"
]

const ALC_LEVEL_CHANGE = [
	["I'm getting desperate", "I'm pretty dry, I NEEED ALC", "I'm getting disgusting low on alcohol", "I'm getting Withdrawal symptoms, I only have a level of 2.0"],
	["I'm getting sober", "Sober life, is a sad live, but at least I can drive", "Is a sober life even worth living"],
	["I could handle some more alc", "One more bottle please ^^", "You should find some alc soon"],
	["I'm le dunk", "Alc, alc, alc is awesome", "More alc more fun"]
]

const GOT_WATER = [
	"Dude, that is water, it has 0% alc",
	"I'm not a kid, give me somthing real to drink",
	"I'm not that drunk",
	"Look at you, trying to give me water"
]

const random_quote = [
	"I drink to make other boots more interesting *cheers*",
	"I can stop when ever I want! Let's have a drink on that my friend",
	"I drink to make my owner more interesting",
	"What do we want to drink, well all of the things!!!!",
	"Voddi, is my life water"
]

var alc_level = 39.0
var delta = 0.0
var drunk_motion = Vector2(1.0, 0)
var drunk_level = 0

func _ready() -> void:
	_display_status("Hello my friend!\nFriends don't let friends drink alone, so drink something with me!")
	pass

func get_movement(delta: float) -> Vector2:
	var speed = get_speed(delta)
	var input_motion = get_movement_request()
	
	match drunk_level:
		0, 1:
			return (input_motion * speed) + (drunk_motion * DRUNK_MOTION_SPEED * delta * 0.5)
		2:
			var rot = sin(self.delta * 10) * randf() * 1
			return (input_motion.rotated(rot) * speed) + (drunk_motion * DRUNK_MOTION_SPEED * delta * 0.75)
		3:
			var rot = sin(self.delta * 10) * randf() * 2.5
			return (input_motion.rotated(rot) * speed) + (drunk_motion * DRUNK_MOTION_SPEED * delta)
		4:
			var rot = sin(self.delta * 10) * randf() * 4
			return (input_motion.rotated(rot) * speed * 0.75) + (drunk_motion * DRUNK_MOTION_SPEED * delta * speed * 0.2)
	
	return Vector2()

func give_item_by_id(id: String):
	if (id == ItemInfo.ALCOHOL_ID):
		_display_random_status(GOT_ALCOKOL)
		_change_mood(+25.0 + 15.0 * (1.0 - randf() * randf()))
		_change_alc(+15.0 + 15.0 * randf() * randf())
	elif (id == ItemInfo.WINE_BOTTLE_ID):
		_display_random_status(GOT_ALCOKOL)
		_change_mood(+10.0 + 15.0 * (1.0 - randf() * randf()))
		_change_alc(+15.0 + 5.0 * randf() * randf())
	elif (id == ItemInfo.WATER_BOTTLE_ID):
		_display_random_status(GOT_WATER)
		_change_mood(-15.0 * (randf() * randf()))
		_change_alc(-15.0 + 5.0 * randf() * 4)
	else:
		var alc_sensation = (alc_level - MIN_ALC_LEVEL) / 100.0
		_display_random_status(UNUSABLE_ITEM)
		_change_mood(min(-10, (-25.0 * randf() * randf())) + -10.0 * (1 - (alc_sensation * alc_sensation)))

func _process(delta: float) -> void:
	self.delta += delta
	var prev_alc_level = alc_level
	_change_alc(-1 * delta)
	
	if (alc_level < 10):
		if (prev_alc_level < 1):
			_display_status("I NEED A DRINK TO KEEP WALKING")
		if (prev_alc_level > 10):
			_display_random_status(ALC_LEVEL_CHANGE[0])
		_change_mood(-5 * delta)
		drunk_level = 0
	elif (alc_level < 20):
		if (prev_alc_level > 20):
			_display_random_status(ALC_LEVEL_CHANGE[0])
		_change_mood(-3 * delta)
		drunk_level = 1
	elif (alc_level < 40):
		if (prev_alc_level < 20):
			_display_random_status(ALC_LEVEL_CHANGE[1])
		_change_mood(-1 * delta)
		drunk_level = 2
	elif (alc_level < 60):
		if (prev_alc_level < 40):
			_display_random_status(ALC_LEVEL_CHANGE[2])
		_change_mood(+1 * delta)
		drunk_level = 3
	elif (alc_level < 80):
		if (prev_alc_level < 60):
			_display_random_status(ALC_LEVEL_CHANGE[3])
		_change_mood(+5 * delta)
		drunk_level = 4
	elif (alc_level < 100):
		_change_mood(+50 * delta)
	
	_gen_drunk_motion()

func _gen_drunk_motion() -> void:
	match drunk_level:
		0:
			var rot = sin(self.delta * 75)
			drunk_motion = Vector2(75 * rot, 0)
		1:
			var rot = sin(self.delta * 75)
			drunk_motion = Vector2(10 * rot, 0)
		2:
			drunk_motion = Vector2(randf(), randf())
		3, 4:
			var b = 0
			match drunk_level:
				3: b = 0.2
				4: b = 0.4
				
			drunk_motion.x = drunk_motion.x * (1 - b) + (randf() * 2 - 1) * b
			drunk_motion.y = drunk_motion.y * (1 - b) + (randf() * 2 - 1) * b
			drunk_motion = drunk_motion.normalized()

func get_speed(delta: float) -> float:
	var alc_sensation = (alc_level - MIN_ALC_LEVEL) / 100.0
	return (BASE_SPEED * (alc_level / 100.0) +
		ALC_MULTIPLIER * (alc_sensation * alc_sensation) +
		MOOD_MULTIPLIER * (get_mood() / 100)) * delta

func _change_alc(change: float) -> void:
	alc_level = clamp(alc_level + change, 0.0, 100.0)

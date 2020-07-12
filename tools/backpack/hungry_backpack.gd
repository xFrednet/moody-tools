extends Backpack

class_name HungryBackpack

const HUNGRY_STATE_CHANGE_MESSAGES = [
	["I'm full :)"],
	["I'm getting a bit hungry", "I would like some food", "Do you mind feeding me?", "Hey, my stomach is growling"],
	["I need some food", "You know what sounds nice? Some FOOD *.*", "Please feed me", "Can I order some food from you?"],
	["I'm starving", "Why can't you feed me, what kind of owner are you", "I WANT SOME FEED", "I DARE YOU TO GIVE ME SOME FOOD", "You are a bad adventurer"]
]

const SLOT_COUNT_CHANGE_MESSAGE = [
	["I can carry more items now", "I'm getting stong", "I can take more items", "New space, so much space"],
	["I can't carry this much any more", "Less food = Less space", "I'm getting thin"]
]

const DONT_PICKUP_ITEM_MESSAGE = [
	"I'm not in the mood to pick that item up",
	"I don't like that item",
	"I woun't pick that up",
	"Do I look like I carry every item you order me to?"
]

var _since_last_feed: float = 0.0
var _hungry_state: int = 0
var _pickup_blacklist: Array = []

func _ready() -> void:
	pass

func give_item_by_id(item_id: String):
	match item_id:
		"i:apple":
			_change_mood(10.0)
			_since_last_feed = 0.0
		"i:meat":
			_change_mood(20.0)
			_since_last_feed = 0.0
		_:
			_change_mood(-25.0 * randf())
			_display_status("I can't eat that, do you want me to die???")

func _process(delta: float) -> void:
	_since_last_feed += delta
	
	# Food status
	if _since_last_feed < 30:
		_hungry_state = 0
		_change_mood(0.5 * delta)
	elif _since_last_feed < 60:
		if (_hungry_state == 0):
			_display_hungry_stage_message(1)
		
		_hungry_state = 1
		_change_mood(0.0 * delta)
	elif _since_last_feed < 90:
		if (_hungry_state == 1):
			_display_hungry_stage_message(2)
		
		_hungry_state = 2
		_change_mood(-1.0 * delta)
	else:
		if (_hungry_state == 2):
			_display_hungry_stage_message(3)
		
		_hungry_state = 3
		_change_mood(-3.0 * delta)

func _display_hungry_stage_message(stage: int) -> void:
	var messages = HUNGRY_STATE_CHANGE_MESSAGES[stage]
	var index = randi() % messages.size()
	_display_status(messages[index])

func pickup_item(new_item: Item) -> void:
	if (_pickup_blacklist.has(new_item.get_id())):
		_display_status("I've allready said, that I don't want to carry that item!")
		return
	
	var chance = randf() - 0.1
	
	if (chance < get_mood()):
		add_item(new_item)
	else:
		_pickup_blacklist.append(new_item.get_id())
		_display_item_not_pickedup_message()

func _display_item_not_pickedup_message() -> void:
	var messages = DONT_PICKUP_ITEM_MESSAGE
	var index = randi() % messages.size()
	_display_status(messages[index])

func _change_mood(change: float):
	var last_mood = get_mood()
	._change_mood(change)
	
	var mood = get_mood()
	if (mood > 90.0):
		if (last_mood < 75.0):
			_change_slots(20)
			_pickup_blacklist.clear()
	elif (mood > 75.0):
		if (last_mood > 90.0 || last_mood < 50.0):
			_change_slots(12)
		
		if (last_mood < 50.0):
			_pickup_blacklist = _pickup_blacklist.slice(0, _pickup_blacklist.size(), 2)
			
	elif (mood > 50.0):
		if (last_mood > 75.0 || last_mood < 25.0):
			_change_slots(6)
			_drop_random_stack()
			
		if (last_mood < 25.0):
			_pickup_blacklist = _pickup_blacklist.slice(0, _pickup_blacklist.size(), 3)
			
	elif (mood > 25.0):
		if (last_mood > 50.0):
			_change_slots(3)
			_drop_random_stack()
	
func _change_slots(new_slot_count: int) -> void:
	_display_change_slot_count_message(1 if ((_slots - new_slot_count) > 1) else 0)
	
	_slots = new_slot_count
	
	var drop_count = min(0, _items.size() - _slots)
	for index in range(drop_count):
		_drop_random_stack()

func _display_change_slot_count_message(change_type: int) -> void:
	var messages = SLOT_COUNT_CHANGE_MESSAGE[change_type]
	var index = randi() % messages.size()
	_display_status(messages[index])
	
func _drop_random_stack() -> void:
	if (_items.size() == 0):
		return 
		
	var index = randi() % _items.size()
	var item = _items[index]
	
	.remove_item(item)
	._drop_item(item)

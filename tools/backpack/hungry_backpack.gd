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
var _mood_modus = 4

func _ready() -> void:
	pass

func give_item_by_id(item_id: String):
	match item_id:
		ItemInfo.APPLE_ID:
			_display_status("An apple a day keeps my happy")
			_change_mood(10.0)
			_since_last_feed = 0.0
		ItemInfo.MEAT_ID:
			_display_status("Uhh tasty meat, thank you sir!")
			_change_mood(20.0)
			_since_last_feed = 0.0
		ItemInfo.WATER_BOTTLE_ID:
			_display_status("It's just water -.-")
			_change_mood(5.0)
			_since_last_feed += 5.0
		ItemInfo.FISH_ID:
			_display_status("Uhh un fish, thank you, it will keep me fed")
			_change_mood(15.0)
			_since_last_feed = 0.0
		ItemInfo.MUSHROOM_ID:
			_display_status("I don't trust these shrooms, but I trust you :)\nIt was okay, but I prefer something different")
			_change_mood(5.0)
			_since_last_feed = 0.0
		ItemInfo.WINE_BOTTLE_ID, ItemInfo.ALCOHOL_ID:
			_display_status("Ohh, damn, nice. But I'm still hungry and the boots are angry, that I got the alcohol")
			_change_mood(25.0)
			GameData.player.get_node("equipment").get_boots()._change_mood(-30.0)
		_:
			_change_mood(-25.0 * randf())
			_display_status("I can't eat that, do you want me to die???")

func _process(delta: float) -> void:
	_since_last_feed += delta
	
	# Food status
	if _since_last_feed < 10:
		_hungry_state = 0
		_change_mood(0.5 * delta)
	elif _since_last_feed < 30:
		if (_hungry_state == 0):
			_display_hungry_stage_message(1)
		
		_hungry_state = 1
		_change_mood(-1.0 * delta)
	elif _since_last_feed < 45:
		if (_hungry_state == 1):
			_display_hungry_stage_message(2)
		
		_hungry_state = 2
		_change_mood(-2.0 * delta)
	else:
		if (_hungry_state == 2):
			_display_hungry_stage_message(3)
		
		_hungry_state = 3
		_change_mood(-5.0 * delta)

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
	
	if (mood < 25.0):
		if (_mood_modus != 0):
			_mood_modus = 0
			_change_slots(3)
			_drop_random_stack()
			
	elif (mood < 50.0):
		if (_mood_modus == 2):
			_pickup_blacklist = _pickup_blacklist.slice(0, _pickup_blacklist.size(), 3)
		
		if (_mood_modus != 1):
			_mood_modus = 1
			_change_slots(4)
			_drop_random_stack()
			
	elif (mood < 75.0):
		if (_mood_modus == 4):
			_pickup_blacklist = _pickup_blacklist.slice(0, _pickup_blacklist.size(), 2)
		
		if (_mood_modus != 3):
			_mood_modus = 3
			_change_slots(6)
			
	elif (mood < 90.0):
		if (_mood_modus != 4):
			_mood_modus = 4
			_change_slots(7)
			_pickup_blacklist.clear()
	
func _change_slots(new_slot_count: int) -> void:
	_display_change_slot_count_message(1 if ((_slots - new_slot_count) > 1) else 0)
	
	_slots = new_slot_count
	
	var drop_count = min(0, _items.size() - _slots)
	for index in range(drop_count):
		_drop_random_stack()
	
	GameData.ingame_menu.get_node("backpack_ui").gen_slots()

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
	._drop_item(item, true)

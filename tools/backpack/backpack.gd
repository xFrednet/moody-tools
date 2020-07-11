extends Tool

class_name Backpack

const NEW_ITEM_TEXT = [
	"You found a new item",
	"Happy Birthday",
	"you have stolen a new item from this precious world, yay you",
	"Are you happy destroying the world around you",
	"Nice find",
	"Ducks",
	"My precious, backpack, backpack"
]

const COLLECTION_TEXT = [
	"*Chomp*",
	"Uhh, tasty thank you",
	"*crunch*",
	"*gulp*",
	"*om nom nom*",
	"yummy",
	"*flop*"
]

var _items: Array = Array()
var _slots: int = 10

func _ready() -> void:
	_display_status("Hey from root")
	pass

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("debug")):
		add_item(Item.new("hello" + str(_items.size()), 2))

func _display_status(text: String) -> void:
	GameData.ingame_menu.find_node("tool_status_display").find_node("backpack").set_status(text)

func get_slot_count() -> int:
	return _slots

func get_items() -> Array:
	return _items

func add_item(new_item: Item) -> void:
	var stack = null
	
	new_item.set_visible(false)
	
	for index in range(_items.size()):
		var item: Item = _items[index]
		if item != null && item.get_id() == new_item.get_id():
			_display_status(
				COLLECTION_TEXT[randi() % COLLECTION_TEXT.size()] + 
				"\n + " + str(new_item.get_count()) + " " + ItemInfo.get_item_name(new_item.get_id()))
			item.add(new_item.get_count())
			return
	
	if (_items.size() < self._slots):
		_display_status(
				NEW_ITEM_TEXT[randi() % NEW_ITEM_TEXT.size()] + 
				"\n + " + str(new_item.get_count()) + " " + ItemInfo.get_item_name(new_item.get_id()) +
				"\nNEW!!!")
		_items.append(new_item)
	else:
		_drop_item(new_item)

func remove_item(item: Item) -> void:
	_items.erase(item)

func _drop_item(item: Item) -> void:
	if item.get_parent():
		item.get_parent().remove_child(item)
				
	item.set_visible(true)
	item.set_position(get_global_transform().get_origin())
	GameData.world.add_entity(item)
	
	_display_status("I dropped a thingy")

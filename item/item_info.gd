extends Node

const WOOD_ID = "i:wood"
const STONE_ID = "i:stone"

const ITEM_NAMES = {
	"i:wood": "Wood",
	"i:stone": "Stone"
}

func get_item_name(id: String) -> String:
	return ITEM_NAMES.get(id, "null")

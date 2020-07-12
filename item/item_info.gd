extends Node

const ALCOHOL_ID = "i:alcohol"
const APPLE_ID = "i:apple"
const MEAT_ID = "i:meat"
const STONE_ID = "i:stone"
const WATER_BOTTLE_ID = "i:water_bottle"
const WINE_BOTTLE_ID = "i:wine_bottle"
const WOOD_ID = "i:wood"
const MUSHROOM_ID = "i:mushroom"
const FISH_ID = "i:fish"

const ITEM_NAMES = {
	"i:alcohol": "Alcohol",
	"i:apple": "Apple",
	"i:meat": "Meat",
	"i:stone": "Stone",
	"i:water_bottle": "Water_bottle",
	"i:wine_bottle": "Wine_bottle",
	"i:wood": "Wood",
	"i:fish": "Fish",
	"i:mushroom": "Mushroom"
}

var item_textures = {
	"i:alcohol":		load("res://item/texture/alcohol.png"),
	"i:apple":			load("res://item/texture/apple.png"),
	"i:meat":			load("res://item/texture/meat.png"),
	"i:stone":			load("res://item/texture/stone.png"),
	"i:water_bottle":	load("res://item/texture/water_bottle.png"),
	"i:wine_bottle":	load("res://item/texture/wine_bottle.png"),
	"i:wood":			load("res://item/texture/wood.png"),
	"i:fish":			load("res://item/texture/fish.png"),
	"i:mushroom":		load("res://item/texture/mushroom.png")
}

var null_texture = load("res://item/texture/null.png")

func get_item_name(id: String) -> String:
	return ITEM_NAMES.get(id, "null")

func get_item_tex(id: String) -> Texture:
	return item_textures.get(id, null_texture)

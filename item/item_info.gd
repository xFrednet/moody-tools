extends Node

const WOOD_ID = "i:wood"
const STONE_ID = "i:stone"

const ITEM_NAMES = {
	"i:wood": "Wood",
	"i:stone": "Stone"
}

var item_textures = {
	"i:wood": load("res://item/texture/wood.png"),
	"i:stone": load("res://item/texture/stone.png"),
}

var null_texture = load("res://item/texture/null.png")

func get_item_name(id: String) -> String:
	return ITEM_NAMES.get(id, "null")

func get_item_tex(id: String) -> Texture:
	return item_textures.get(id, null_texture)

extends Node2D

var boots : Boots = null
var pants : Tool = null
var shirt : Tool = null
var helmet : Tool = null

var backpack : Backpack = null
var sword : Tool = null

func _ready() -> void:
	pass

#
# boots
#
func set_boots(boots: Boots) -> void:
	if (self.boots != null):
		remove_child(self.boots)
	self.boots = boots
	add_child(boots)

func get_boots() -> Boots:
	return boots

#
# pants
#
func set_pants(pants: Tool) -> void:
	if (self.pants != null):
		remove_child(self.pants)
	self.pants = pants
	add_child(pants)

func get_pants() -> Tool:
	return pants

#
# shirt
#
func set_shirt(shirt: Tool) -> void:
	if (self.shirt != null):
		remove_child(self.shirt)
	self.shirt = shirt
	add_child(shirt)

func get_shirt() -> Tool:
	return shirt

#
# helmet
#
func set_helmet(helmet: Tool) -> void:
	if (self.helmet != null):
		remove_child(self.helmet)
	self.helmet = helmet
	add_child(helmet)

func get_helmet() -> Tool:
	return helmet

#
# backpack
#
func set_backpack(backpack: Backpack) -> void:
	if (self.backpack != null):
		remove_child(self.backpack)
	self.backpack = backpack
	add_child(backpack)
	GameData.ingame_menu.get_node("backpack_ui").set_backpack(backpack)

func get_backpack() -> Backpack:
	return backpack

#
# sword
#
func set_sword(sword: Tool) -> void:
	if (self.sword != null):
		remove_child(self.sword)
	self.sword = sword
	add_child(sword)

func get_sword() -> Tool:
	return sword



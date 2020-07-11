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
	remove_child(self.boots)
	self.boots = boots
	add_child(boots)

func get_boots() -> Boots:
	return boots

#
# pants
#
func set_pants(pants: Tool) -> void:
	remove_child(self.boots)
	self.pants = pants
	add_child(pants)

func get_pants() -> Tool:
	return pants

#
# shirt
#
func set_shirt(shirt: Tool) -> void:
	remove_child(self.pants)
	self.shirt = shirt
	add_child(shirt)

func get_shirt() -> Tool:
	return shirt

#
# helmet
#
func set_helmet(helmet: Tool) -> void:
	remove_child(self.shirt)
	self.helmet = helmet
	add_child(helmet)

func get_helmet() -> Tool:
	return helmet

#
# backpack
#
func set_backpack(backpack: Backpack) -> void:
	remove_child(self.helmet)
	self.backpack = backpack
	add_child(backpack)

func get_backpack() -> Backpack:
	return backpack

#
# sword
#
func set_sword(sword: Tool) -> void:
	remove_child(self.backpack)
	self.sword = sword
	add_child(sword)

func get_sword() -> Tool:
	return sword



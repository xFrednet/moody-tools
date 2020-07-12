extends KinematicBody2D

export(int) var speed = 200

func _init() -> void:
	GameData.player = self

func _ready() -> void:
	
	$equipment.set_boots(DunkBoots.new())
	$equipment.set_backpack(HungryBackpack.new())
	
	$equipment.get_backpack().pickup_item(Item.new(ItemInfo.ALCOHOL_ID, 10))
	
	pass

func _physics_process(delta: float) -> void:
	var motion = $equipment.get_boots().get_movement(delta)
	move_and_slide(motion)

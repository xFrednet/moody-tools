extends KinematicBody2D

export(int) var speed = 200

func _init() -> void:
	GameData.player = self

func _ready() -> void:
	
	var boots = DunkBoots.new()
	$equipment.set_boots(boots)
	$equipment.set_backpack(Backpack.new())
	
	pass

func _physics_process(delta: float) -> void:
	var motion = $equipment.get_boots().get_movement(delta)
	move_and_slide(motion)

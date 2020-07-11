extends KinematicBody2D

export(int) var speed = 200

#var velocity = Vector2()

func _ready() -> void:
	
	var boots = DunkBoots.new()
	$equipment.set_boots(boots)
	
	pass

func _physics_process(delta: float) -> void:
	var motion = $equipment.get_boots().get_movement(delta)
	move_and_slide(motion)

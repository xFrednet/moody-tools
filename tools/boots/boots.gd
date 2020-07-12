extends Tool

class_name Boots

func _ready() -> void:
	pass

func _display_random_status(texts: Array) -> void:
	var index = randi() % texts.size()
	_display_status(texts[index])

func _display_status(text: String) -> void:
	GameData.ingame_menu.find_node("tool_status_display").find_node("boots").set_status(text)

func get_movement(delta: float) -> Vector2:
	return get_movement_request()

func get_speed(delta: float) -> float:
	return 1.0

func get_movement_request() -> Vector2:
	var velocity = Vector2()
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1 
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	
	return velocity

func update_mood_display() -> void:
	GameData.ingame_menu.find_node("tool_status_display").find_node("boots").set_mood(mood)

extends Control

var slot_texture = load("res://ui/ingame/inventory/item_slot.png")

var backpack : Backpack = null

func _ready() -> void:
	set_visible(false)
	pass

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("open_backpack")):
		set_visible(!is_visible())
		if (is_visible()):
			gen_slots()

func set_backpack(backpack: Backpack) -> void:
	self.backpack = backpack

func gen_slots() -> void:
	for index in range($item_grid.get_child_count()):
		$item_grid.remove_child($item_grid.get_child(0))
	
	if (backpack == null): 
		return
	
	var items = backpack.get_items()
	
	for slot in range(backpack.get_slot_count()):
		var slot_ui = TextureRect.new()
		slot_ui.set_expand(true)
		slot_ui.set_stretch_mode(TextureRect.STRETCH_SCALE)
		slot_ui.set_texture(slot_texture)
		slot_ui.set_size(Vector2(64, 64))
		slot_ui.set_position(Vector2(64 * (slot % 5), 64 * (slot / 5)))
		$item_grid.add_child(slot_ui)
		
		if (slot < items.size()):
			var item = items[slot]
			
			if item.get_parent():
				item.get_parent().remove_child(item)
			
			if (item != null):
				slot_ui.add_child(item)
				item.set_visible(true)
#				item.set_anchors_preset(Control.PRESET_CENTER)
				item.set_position(Vector2(16, 16))

extends TextureRect

class_name Item

var id: String
var count: int
var count_label: Label = null

var mouse_inside: bool = false
var popup = PopupMenu.new()

func _init(id: String, count: int) -> void:
	self.id = id
	self.count = count
	
	# Set display properies
	set_expand(true)
	set_stretch_mode(TextureRect.STRETCH_SCALE)
	set_texture(ItemInfo.get_item_tex(id))
	set_size(Vector2(32, 32))
	set_tooltip(ItemInfo.get_item_name(id))
	
	# Add count label
	count_label = Label.new();
	count_label.set_text(str(count))
	self.add_child(count_label)
	count_label.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	
	connect("mouse_entered", self, "_mouse_entered")
	connect("mouse_exited", self, "_mouse_exited")
	
	# Popup
	popup = PopupMenu.new()
	self.add_child(popup)
#	popup.add_item("Give to: Helmet"  , 1001)
#	popup.add_item("Give to: Shirt"   , 1002)
#	popup.add_item("Give to: Pants"   , 1003)
	popup.add_item("Give to: Boots"   , 1004)
#	popup.add_item("Give to: Weapon"  , 1005)
	popup.add_item("Give to: Backpack", 1006)
	popup.add_separator()
	popup.add_item("Drop", 2001)
	
	popup.connect("id_pressed", self, "_on_item_pressed")

func _input(event: InputEvent) -> void:
	if (!is_visible() || !(event is InputEventMouseButton)):
		return
	
	var mouse = event as InputEventMouseButton
	var local_pos = get_local_mouse_position()
	if (local_pos.x < 0 || local_pos.x >= get_size().x ||
			local_pos.y < 0 || local_pos.y >= get_size().y):
				return
	
	if (mouse.get_button_index() == BUTTON_RIGHT && mouse.is_pressed()):
		if (get_parent() is Control):
			popup.set_position(get_global_mouse_position())
			popup.popup()
			
	if (mouse.get_button_index() == BUTTON_LEFT && mouse.is_pressed()):
		if (get_parent() is Node2D):
			GameData.player.get_node("equipment").get_backpack().pickup_item(self)

func _mouse_entered() -> void:
	mouse_inside = true

func _mouse_exited() -> void:
	mouse_inside = false

func _on_item_pressed(id) -> void:
	var equipment = GameData.player.get_node("equipment")
	var backpack = equipment.get_backpack()
	match (id):
		1001:
			add(-1)
			equipment.get_helmet().give_item_by_id(get_id())
			# Helmet
		1002:
			add(-1)
			equipment.get_shirt().give_item_by_id(get_id())
			# Shirt
		1003:
			add(-1)
			equipment.get_pants().give_item_by_id(get_id())
			# Pants
		1004:
			add(-1)
			equipment.get_boots().give_item_by_id(get_id())
			# Boots
		1005:
			add(-1)
			equipment.get_weapon().give_item_by_id(get_id())
			# Weapon
		1006:
			add(-1)
			equipment.get_backpack().give_item_by_id(get_id())
			# Backpack
		2001:
			backpack.remove_item(self)
			backpack._drop_item(self)
		_:
			print("What do you want me to do, who are YOU")

	if (count == 0):
		backpack.remove_item(self)
		set_visible(false)

func get_id() -> String:
	return id

func get_count() -> int:
	return count
	
func add(count: int) -> void:
	self.count += count
	count_label.set_text(str(self.count))

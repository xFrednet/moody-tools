extends TextureRect

class_name Item

var id: String
var count: int
var count_label: Label = null

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

func get_id() -> String:
	return id

func get_count() -> int:
	return count
	
func add(count: int) -> void:
	self.count += count
	count_label.set_text(str(count))

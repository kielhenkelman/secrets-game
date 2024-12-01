extends Node2D

var item_id: String
var item_parts: Array
var selected = false
var slot_anchor_id: int

var item_name: String
var item_value: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		
func load_item(game_item: GameItem):
	item_id = game_item.item_id
	item_parts = game_item.item_parts
	item_name = game_item.item_name
	item_value = game_item.item_value
	$Icon.texture = game_item.icon_texture
		
func snap_to_smooth(destination):
	var tween = get_tree().create_tween()
	destination += $Icon.size / 2 * 0.69
	tween.tween_property(self, "global_position", destination, 0.15).set_trans(Tween.TRANS_SINE)
	selected = false

func snap_to(destination):
	destination += $Icon.size / 2 * 0.69
	self.global_position = destination
	selected = false

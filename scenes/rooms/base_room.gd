extends Node2D

class_name BaseRoom

var item_template = preload("res://clickable_item.tscn")

func spawn_items(room_name: String) -> Dictionary:
	var items_dict = {}
	for item_id in GameState.ITEM_DATA:
		var game_item = GameState.ITEM_DATA[item_id]
		if game_item.spawn_room == room_name:
			var new_item = item_template.instantiate()
			new_item.game_item = game_item
			items_dict[game_item.item_id] = new_item
			add_child(new_item)
			
	return items_dict

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D

class_name BaseRoom

var item_template = preload("res://clickable_item.tscn")

func create_item(data):
	var new_item = item_template.instantiate()
	new_item.item_name = data['NAME']
	
	if 'INSPECT_TEXT' in data:
		new_item.inspect_text = data['INSPECT_TEXT']
	
	if 'CAN_GRAB' in data:
		new_item.can_grab = data['CAN_GRAB']
	
	if 'INTERACTIONS' in data:	
		new_item.interactions = data['INTERACTIONS']

	if 'TEXTURE' in data:
		new_item.hitbox_texture = data['TEXTURE']['HITBOX']
		
		if 'HIDDEN' in data['TEXTURE']:
			new_item.hidden_texture = data['TEXTURE']['HIDDEN']
		
		if 'GLOW' in data['TEXTURE']:
			new_item.glow_texture = data['TEXTURE']['GLOW']
	
	if 'HIDDEN' in data['SPAWN']:
		new_item.hide_item()
	
	return new_item

func spawn_items(room_name: String) -> Dictionary:
	var items_dict = {}
	for item in ItemData.items:
		if 'SPAWN' in item && item['SPAWN']['ROOM'] == room_name:
			var new_item = create_item(item)
			items_dict[item['NAME']] = new_item
			add_child(new_item)
	return items_dict

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

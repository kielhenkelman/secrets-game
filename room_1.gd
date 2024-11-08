extends Node2D

@export var item_template: PackedScene

var items = {}

func create_item(item):
	var new_item = item_template.instantiate()
	new_item.item_name = item['NAME']
	new_item.can_grab = item['CAN_GRAB']
	new_item.set_texture(item['ART'])
	new_item.position = item['SPAWN']['POSITION']
	new_item.interactions = item['INTERACTIONS']
	
	var item_scale = item['SCALE']
	new_item.set_item_scale(item_scale['SPRITE'], item_scale['COLLISION'])
	
	if 'HIDDEN' in item['SPAWN']:
		new_item.visible = false
	
	return new_item
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("flag_updated", on_flag_updated) 
	
	for item in ItemData.items:
		var new_item = create_item(item)
		items[item['NAME']] = new_item
		add_child(new_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_flag_updated(flag: String, value: Variant):
	if flag == 'BOX_OPENED':
		items['LOCKED_BOX'].set_texture(preload('res://art/chest-open.png'))
		items['LOCKED_BOX'].clickable = false
		items['GEM'].visible = true
		items['GEM'].z_index = 2
	

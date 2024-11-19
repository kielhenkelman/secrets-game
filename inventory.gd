extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	render_items()

func render_items() -> void:
	for node in get_children():
		if node != $ItemTemplate:
			remove_child(node)
	
	var pos_y = -150
	for item in GameState.INVENTORY:
		var item_label = $ItemTemplate.duplicate()
		item_label.position = Vector2(-200, pos_y)
		item_label.text = item
		item_label.visible = true
		add_child(item_label)
		pos_y += 40
		
		
func add_item(item_name: String) -> void:
	GameState.INVENTORY.append(item_name)
	render_items()
	
func _process(delta: float) -> void:
	render_items()

extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_inventory.call_deferred()
	
func show_inventory():
	$Inventory.inventory_open = true
	$Inventory.visible = true
	$Inventory.render_items.call_deferred()
	
func hide_inventory():
	$Inventory.inventory_open = false
	$Inventory.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	if $Inventory.visible:
		hide_inventory.call_deferred()
	else:
		show_inventory.call_deferred()
		

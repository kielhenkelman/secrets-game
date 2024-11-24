extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Inventory.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if $Inventory.visible:
		$Inventory.inventory_open = false
		$Inventory.visible = false
	else:
		$Inventory.inventory_open = true
		$Inventory.visible = true

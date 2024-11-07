extends Area2D

signal item_grabbed

@export var context_button: PackedScene

var counter = 0

var context_events = [
	{"label": "inspect", "action": inspect_action}
]

func drop_action() -> void:
	print("drop() action")
	
func grab_action() -> void:
	print("grab() called")
	GameState.inventory.append("key")
	self.visible = false
	
func inspect_action() -> void:
	print("inspect() called")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ContextMenu.visible = false
	$Debug.text = "Count: " + str(counter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_button(label: String, action: Callable) -> Button:
	var new_button = context_button.instantiate()
	new_button.text = label
	new_button.action = click_menu_item(action)
	return new_button
#
func click_menu_item(action: Callable):
	var inner = func inner():
		action.call()
		$ContextMenu.visible = false
	return inner
		
func draw_context_menu():
	for n in $ContextMenu.get_children():
		$ContextMenu.remove_child(n)
		n.queue_free()
	
	$ContextMenu.add_child(create_button("grab", grab_action))
	
	for event in context_events:
		$ContextMenu.add_child(create_button(event["label"], event["action"]))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		draw_context_menu()
		
		var mouse_position = get_global_mouse_position()
		mouse_position.x += 15
		mouse_position.y += 15
		$ContextMenu.global_position = mouse_position
		$ContextMenu.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		$ContextMenu.visible = false

	
func my_function():
	$Debug.text = "my_function()"


func _on_button_pressed() -> void:
	print("pressed")
	pass # Replace with function body.

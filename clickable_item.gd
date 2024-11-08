extends Area2D

class_name ClickableItem

@export var context_button: PackedScene

var clickable: bool = true
var item_name: String
var can_grab: bool
var inspect_text: String

var interactions = []

	
func grab_action(_self) -> void:
	print("grab() called")
	GameState.INVENTORY.append(item_name)
	self.visible = false
	
func inspect_action(_self) -> void:
	print("inspect() called")
	
func _ready() -> void:
	$ContextMenu.visible = false

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
		action.call(self)
		$ContextMenu.visible = false
	return inner
		
func draw_context_menu():
	for n in $ContextMenu.get_children():
		$ContextMenu.remove_child(n)
		n.queue_free()
	
	if can_grab:
		$ContextMenu.add_child(create_button("grab", grab_action))
	
	for i in interactions:
		if i['SHOW_IF'].call():
			$ContextMenu.add_child(create_button(i['LABEL'], i['RESULT']))
		
	$ContextMenu.add_child(create_button("inspect", inspect_action))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("interact") and clickable:
		print("pressed: " + item_name)
		draw_context_menu()
		
		var mouse_position = get_global_mouse_position()
		mouse_position.x += 15
		mouse_position.y += 15
		$ContextMenu.global_position = mouse_position
		$ContextMenu.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		$ContextMenu.visible = false

func set_texture(texture: Texture2D):
	$Sprite2D.texture = texture

func set_item_scale(sprite: Vector2, shape: Vector2):
	$Sprite2D.set_scale(sprite)
	$CollisionShape2D.set_scale(shape)

extends Area2D

class_name ClickableItem

@export var context_button: PackedScene

var game_item: GameItem
var clickable: bool = true

var cursor_default = load("res://art/idc_arrow.png")
var cursor_help = load("res://art/idc_help.png")

func hide_item() -> void:
	clickable = false
	$Sprite2D.texture = game_item.hidden_texture
	$Glow.texture = game_item.default_texture
	
func show_item() -> void:
	clickable = true
	$Sprite2D.texture = game_item.default_texture

func grab_action(_self) -> void:
	if GameState.can_fit_item(game_item.item_id):
		GameState.grab_item(game_item.item_id)
		hide_item()
	else:
		GameState.popup_inventory_full()
	
func inspect_action(_self) -> void:
	GameState.popup(game_item.inspect_text)

func create_collision_polygon(collision_texture: Resource):
	var image = Image.new()
	image.load(collision_texture.resource_path)
	
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)
	
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()))
	
	for polygon in polygons:
		var collider = CollisionPolygon2D.new()
		collider.polygon = polygon
		add_child(collider)

func _ready() -> void:
	$ContextMenu.visible = false
	create_collision_polygon(game_item.hitbox_texture)

func _process(delta: float) -> void:
	pass

func create_button(label: String, action: Callable) -> Button:
	var new_button = context_button.instantiate()
	new_button.text = label
	new_button.action = click_menu_item(action)
	return new_button

func click_menu_item(action: Callable):
	var inner = func inner():
		action.call(self)
		$ContextMenu.visible = false
	return inner
		
func draw_context_menu():
	for n in $ContextMenu.get_children():
		$ContextMenu.remove_child(n)
		n.queue_free()
	
	if game_item.can_grab:
		$ContextMenu.add_child(create_button("grab", grab_action))
	
	for i in game_item.interactions:
		if 'SHOW_IF' not in i or i['SHOW_IF'].call():
			$ContextMenu.add_child(create_button(i['LABEL'], i['RESULT']))
	
	if game_item.inspect_text:
		$ContextMenu.add_child(create_button("inspect", inspect_action))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("interact") and clickable:
		print("pressed: " + game_item.item_id)
		draw_context_menu()
		
		var mouse_position = get_global_mouse_position()
		
		var offset_x = 25
		var offset_y = 25
		if mouse_position.y > 600:
			offset_y = -100
		if mouse_position.x > 1100:
			offset_x = -100
			
		mouse_position.x += offset_x
		mouse_position.y += offset_y
		$ContextMenu.global_position = mouse_position
		$ContextMenu.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		$ContextMenu.visible = false
	if event.is_action_pressed("highlight_all") and clickable:
		$Glow.texture = game_item.glow_texture
	if event.is_action_released("highlight_all"):
		$Glow.texture = game_item.default_texture

func set_texture(texture: Texture2D):
	$Sprite2D.texture = texture

func _on_mouse_entered() -> void:
	if clickable:
		Input.set_custom_mouse_cursor(cursor_help)
		$Glow.texture = game_item.glow_texture
	else:
		Input.set_custom_mouse_cursor(cursor_default)
		$Glow.texture = game_item.default_texture
		
func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(cursor_default)
	if not Input.is_action_pressed("highlight_all"):
		$Glow.texture = game_item.default_texture

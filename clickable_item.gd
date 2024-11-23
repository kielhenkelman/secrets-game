extends Area2D

class_name ClickableItem

@export var context_button: PackedScene

var clickable: bool = true

var item_name: String
var can_grab: bool
var inspect_text: String

var interactions = []

var cursor_default = load("res://art/idc_arrow.png")
var cursor_help = load("res://art/idc_help.png")

var default_texture = load("res://art/empty_placeholder.png")
var hitbox_texture: Resource
var hidden_texture: Resource
var glow_texture: Resource

func hide_item() -> void:
	clickable = false
	$Sprite2D.texture = hidden_texture
	
func show_item() -> void:
	clickable = true
	$Sprite2D.texture = default_texture

func grab_action(_self) -> void:
	GameState.grab_item(item_name)
	hide_item()
	
func inspect_action(_self) -> void:
	GameState.popup(inspect_text)

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
	create_collision_polygon(hitbox_texture)

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
	
	if can_grab:
		$ContextMenu.add_child(create_button("grab", grab_action))
	
	for item in interactions:
		if 'SHOW_IF' not in item or item['SHOW_IF'].call():
			$ContextMenu.add_child(create_button(item['LABEL'], item['RESULT']))
	
	if inspect_text:
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

func _on_mouse_entered() -> void:
	if clickable:
		Input.set_custom_mouse_cursor(cursor_help)
		$Glow.texture = glow_texture
	else:
		Input.set_custom_mouse_cursor(cursor_default)
		$Glow.texture = default_texture
		
func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(cursor_default)
	$Glow.texture = default_texture
	

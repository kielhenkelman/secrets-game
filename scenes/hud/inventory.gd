extends Control

@onready var slot_scene = preload("res://scenes/hud/slot.tscn")
@onready var item_scene = preload("res://scenes/hud/inventory_item.tscn")

@onready var held_item_label = $Background/MarginContainer/VBoxContainer/Header/CurrentItemName
@onready var scroll_container = $Background/MarginContainer/VBoxContainer/ScrollContainer
@onready var grid_container = $Background/MarginContainer/VBoxContainer/ScrollContainer/GridContainer

var inventory_open = false

static var States = preload("res://scenes/hud/slot.gd").States
static var col_count = 8
static var inventory_slots = []
static var inventory_items = {}

var item_held = null
var current_slot = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("item_grabbed", _on_item_grabbed)
	GameState.connect("item_dropped", _on_item_dropped) 
	for i in range(64):
		create_slot()
		
func _process(delta: float) -> void:
	if not inventory_open:
		return
	
	if item_held:
		if Input.is_action_just_pressed("interact"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				put_down_item(item_held, current_slot)
		if Input.is_action_just_pressed("drop"):
			throw_away_item(item_held)
	else:
		if Input.is_action_just_pressed("interact"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				pick_up_item(current_slot)

func throw_away_item(inv_item):
	inv_item.queue_free()
	inventory_items.erase(inv_item.item_id)

	reset_slot_highlights()
	
	held_item_label.text = ""
	item_held = null
	
func put_down_item(inv_item, inv_slot):
	if not inv_slot or not can_place_item(inv_item.item_parts, inv_slot): 
		return
	
	add_item_to_grid(inv_item, inv_slot)
	place_item_on_grid(inv_item, true)
	reset_slot_highlights()
	
	held_item_label.text = ""
	item_held = null
	
	
func pick_up_item(inv_slot):
	if not inv_slot or not inv_slot.item_stored: 
		return
		
	var inv_item = inv_slot.item_stored
	inv_item.selected = true
	
	inv_item.get_parent().remove_child(inv_item)
	add_child(inv_item)
	inv_item.global_position = get_global_mouse_position()
	
	for part in inv_item.item_parts:
		var slot_to_check = inv_item.slot_anchor_id + part[0] + part[1] * col_count
		inventory_slots[slot_to_check].state = States.FREE 
		inventory_slots[slot_to_check].item_stored = null
	
	set_slot_highlights.call_deferred(inv_item.item_parts, current_slot)
	
	held_item_label.text = inv_item.item_id
	item_held = inv_item
		
func top_left_corner(inv_item):
	var top_left = Vector2(100, 100)
	for part in inv_item.item_parts:
		if part[1] < top_left.x: top_left.x = part[1]
		if part[0] < top_left.y: top_left.y = part[0]
	return top_left
	
func place_item_on_grid(inv_item, smooth := false):
	var top_left = top_left_corner(inv_item)
	var top_left_slot_id = inv_item.slot_anchor_id + top_left.x * col_count + top_left.y
	var anchor_slot = inventory_slots[top_left_slot_id]
	
	grid_container.add_child(inv_item)
	if smooth:
		inv_item.snap_to_smooth(anchor_slot.global_position)
	else:
		inv_item.snap_to(anchor_slot.global_position)
	
func render_items():
	for item_id in inventory_items:
		var inv_item = inventory_items[item_id]
		var parent = inv_item.get_parent()
		if parent: parent.remove_child(inv_item)
	
	for item_id in inventory_items:
		var inv_item = inventory_items[item_id]
		place_item_on_grid.call_deferred(inv_item)
		
func _on_item_dropped(item_id):
	inventory_items.erase(item_id)
	
func _on_item_grabbed(item_id):
	var game_item: GameItem = GameState.ITEM_DATA[item_id]
	
	var inv_item = item_scene.instantiate()
	inv_item.load_item(game_item)
	
	var anchor_slot = find_empty_slot(inv_item.item_parts)
	add_item_to_grid(inv_item, anchor_slot)
	
	inventory_items[item_id] = inv_item

static func reset_slot_highlights():
	for slot in inventory_slots:
		slot.set_color(States.DEFAULT)	
		
static func has_item(item_id) -> bool:
	return item_id in inventory_items
	
static func can_fit_item(item_id) -> bool:
	var parts = GameState.ITEM_DATA[item_id].item_parts
	return find_empty_slot(parts) != null

static func find_empty_slot(item_parts):
	for slot in inventory_slots:
		if can_place_item(item_parts, slot):
			return slot
	return null
	
static func can_place_item(item_parts, inv_slot) -> bool:
	for part in item_parts:
		var slot_to_check = inv_slot.slot_id + part[0] + part[1] * col_count
		var line_switch_check = inv_slot.slot_id % col_count + part[0]
		if line_switch_check < 0 or line_switch_check >= col_count:
			return false
		if slot_to_check < 0 or slot_to_check >= inventory_slots.size():
			return false
		if inventory_slots[slot_to_check].state == States.TAKEN:
			return false
	return true

func add_item_to_grid(inv_item, inv_spot):
	for part in inv_item.item_parts:
		var slot_to_check = inv_spot.slot_id + part[0] + part[1] * col_count
		inventory_slots[slot_to_check].state = States.TAKEN
		inventory_slots[slot_to_check].item_stored = inv_item
	
	inv_item.slot_anchor_id = inv_spot.slot_id

func set_slot_highlights(item_parts, inv_slot):
	for part in item_parts: 
		var slot_to_check = inv_slot.slot_id + part[0] + part[1] * col_count
		if slot_to_check < 0 or slot_to_check >= inventory_slots.size():
			continue
		# make sure the item doesn't wrap around borders
		var line_switch_check = inv_slot.slot_id % col_count + part[0]
		if line_switch_check < 0 or line_switch_check >= col_count:
			continue
		
		if can_place_item(item_parts, inv_slot):
			inventory_slots[slot_to_check].set_color(States.FREE)
		else:
			inventory_slots[slot_to_check].set_color(States.TAKEN)
			
func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_id = inventory_slots.size()
	grid_container.add_child(new_slot)
	inventory_slots.append(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered)
	new_slot.slot_exited.connect(_on_slot_mouse_exited)
	print(new_slot.global_position)
	
func _on_slot_mouse_entered(inv_slot):
	current_slot = inv_slot
	if item_held:
		set_slot_highlights.call_deferred(item_held.item_parts, current_slot)

func _on_slot_mouse_exited(inv_slot):
	reset_slot_highlights()
	if not grid_container.get_global_rect().has_point(get_global_mouse_position()):
		current_slot = null

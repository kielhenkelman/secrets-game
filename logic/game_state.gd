extends Node

var _inventory = load("res://scenes/hud/inventory.gd")

signal flag_updated(flag, value)
signal item_grabbed(item_id)
signal item_dropped(item_id)
signal room_changed(room_id)
signal popup_added(text, duration)

var ITEM_DATA = {}
var FLAGS = {}

var rooms = [
	"Gallery",
	"Garage",
	"Studio",
	"Cellar",
	"Observatory",
	"Kitchen"
]

var oven = {
	start_time = -1
}

var current_room = "Gallery"

func _ready():
	load_data()
	

func load_data():
	for item in ItemData.items:
		var game_item = GameItem.new()
		game_item.load_json(item)
		ITEM_DATA[game_item.item_id] = game_item
	
func change_room(room_name):
	room_changed.emit(room_name)
	current_room = room_name

func popup_inventory_full():
	popup("Not enough inventory space.")
	
func popup(text: String, duration: float = 3):
	popup_added.emit(text, duration)
	
func set_flag(flag: String, value := true) -> void:
	flag_updated.emit(flag, value)
	FLAGS[flag] = value

func grab_item(item_id) -> void:
	if can_fit_item(item_id):
		item_grabbed.emit(item_id)
	else:
		popup_inventory_full()
	
func drop_item(item_id) -> void:
	item_dropped.emit(item_id)

func has_item(item_id) -> bool:
	return _inventory.has_item(item_id)

func can_fit_item(item_id):
	return _inventory.can_fit_item(item_id)
	
func start_oven() -> void:
	oven.start_time = Time.get_ticks_msec()

func stop_oven() -> void:
	oven.start_time = -1;

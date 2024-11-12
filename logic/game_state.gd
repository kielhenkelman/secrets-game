extends Node

signal flag_updated(flag, value)
signal item_grabbed(item_name)
signal item_dropped(item_name)
signal room_changed(room_id)
signal popup_added(text, duration)

var FLAGS = {}
var INVENTORY = []

var rooms = [
	"Gallery",
	"Garage",
	"Studio",
	"Cellar",
	"Observatory",
	"Kitchen"
]

var current_room = "Gallery"

func change_room(room_name):
	room_changed.emit(room_name)
	current_room = room_name

func popup(text: String, duration: float = 3):
	popup_added.emit(text, duration)
	
func set_flag(flag: String, value := true) -> void:
	flag_updated.emit(flag, value)
	FLAGS[flag] = value

func grab_item(item_name) -> void:
	item_grabbed.emit(item_name)
	INVENTORY.append(item_name)
	
func drop_item(item_name) -> void:
	item_dropped.emit(item_name)
	INVENTORY.erase(item_name)

func has_item(item_name) -> bool:
	return INVENTORY.has(item_name)
	

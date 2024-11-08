extends Node

signal flag_updated(flag, value)
signal item_grabbed(item_name)
signal item_dropped(item_name)

var FLAGS = {}
var INVENTORY = []

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

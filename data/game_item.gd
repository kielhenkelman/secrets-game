extends Node

class_name GameItem

var item_id: String
var can_grab: bool
var inspect_text: String
var spawn_room: String

var interactions = []

var default_texture = load("res://art/empty_placeholder.png")
var hitbox_texture: Resource
var hidden_texture: Resource
var glow_texture: Resource
var icon_texture: Resource

var item_size: String
var item_value: int

var item_parts: Array

var PARTS_DATA = {
	'1x1': [[0,0]],
	'2x1': [[0,0],[-1,0]],
	'1x2': [[0,0],[0,-1]],
	'2x2': [[0,0],[0,-1],[-1,0],[-1,-1]],
	'3x1': [[0,0],[-1,0],[1,0]],
	'1x3': [[0,0],[0,-1],[0,1]],
	'1x4': [[0,0],[0,-1],[0,1],[0,-2]],
	'2x3': [[0,0],[0,-1],[0,1],[-1,0],[-1,-1],[-1,1]],
	'3x4': [[0,0], [-1,0],[1,0],[-1,1],[0,1],[1,1],[-1,-1],[0,-1],[1,-1],[-1,-2],[0,-2],[1,-2]]
}

		
func load_json(item_json):
	item_id = item_json['NAME']
	
	if 'CAN_GRAB' in item_json:
		can_grab = item_json['CAN_GRAB']
	else:
		can_grab = false
	
	if 'INSPECT_TEXT' in item_json:
		inspect_text = item_json['INSPECT_TEXT']
	
	if 'INTERACTIONS' in item_json:
		interactions = item_json['INTERACTIONS']
	
	if 'SIZE' in item_json:
		item_size = item_json['SIZE']
		item_parts = PARTS_DATA[item_size]
	
	if 'VALUE' in item_json:
		item_value = item_json['VALUE']
	
	if 'SPAWN' in item_json and 'ROOM' in item_json['SPAWN']:
		spawn_room = item_json['SPAWN']['ROOM']
	
	if 'TEXTURE' in item_json:
		if 'HITBOX' in item_json['TEXTURE']:
			hitbox_texture = item_json['TEXTURE']['HITBOX']
		
		if 'HIDDEN' in item_json['TEXTURE']:
			hidden_texture = item_json['TEXTURE']['HIDDEN']
		
		if 'GLOW' in item_json['TEXTURE']:
			glow_texture = item_json['TEXTURE']['GLOW']
		
		if 'ICON' in item_json['TEXTURE']:
			icon_texture = item_json['TEXTURE']['ICON']

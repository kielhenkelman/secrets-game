extends Node

const ClickableItem = preload("res://clickable_item.gd")

var items = [
	{
		"NAME": "MAGNET",
		"ART": preload("res://art/magnet.png"),
		"SCALE": {
			"SPRITE": Vector2(.1, .1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "ROOM_1",
			"POSITION": Vector2(100, 500),
		},
		"INSPECT_TEXT": "Looks like a regular magnet.",
		"INTERACTIONS": []
	},
	{
		"NAME": "GEM",
		"ART": preload("res://art/gemstone.png"),
		"SCALE": {
			"SPRITE": Vector2(.1, .1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "ROOM_1",
			"POSITION": Vector2(210, 320),
			"HIDDEN": true
		},
		"INSPECT_TEXT": "This gem looks to be worth a hefty amount.",
		"INTERACTIONS": []
	},
	{
		"NAME": "KEYS",
		"ART": preload("res://art/key-1.png"),
		"SCALE": {
			"SPRITE": Vector2(.1, .1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "ROOM_1",
			"POSITION": Vector2(600, 440)
		},
		"INSPECT_TEXT": "Shiny set of keys. Surely they open something.",
		"INTERACTIONS": [
			{
				"LABEL": "Reach with Magnet",
				"SHOW_IF": func():
					return GameState.has_item("MAGNET"),
				"RESULT": func(item: ClickableItem):
					GameState.grab_item("KEY")
					item.visible = false,
			}
		]
	},
	{
		"NAME": "LOCKED_BOX",
		"ART": preload("res://art/chest-closed.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(1, 1)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "ROOM_1",
			"POSITION": Vector2(210, 320)
		},
		"INSPECT_TEXT": "Looks like there could be something valueable inside.",
		"INTERACTIONS": [
			{
				"LABEL": "Open Box",
				"SHOW_IF": func():
					return GameState.has_item("KEY"),
				"RESULT": func(item: ClickableItem):
					GameState.set_flag("BOX_OPENED"),
			}
		]
	}
]

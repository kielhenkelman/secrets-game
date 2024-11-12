extends Node

const ClickableItem = preload("res://clickable_item.gd")

var items = [
	{
		"NAME": "VAULT",
		"ART": preload("res://art/items/vault_locked.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Cellar",
			"POSITION": Vector2(200, 300)
		},
		"INSPECT_TEXT": "Looks like there could be something valueable inside.",
		"INTERACTIONS": [
			{
				"LABEL": "Open Vault",
				"SHOW_IF": func():
					return GameState.has_item("VAULT_KEY"),
				"RESULT": func(item: ClickableItem):
					GameState.set_flag("VAULT_OPENED"),
			}
		]
	},
	{
		"NAME": "VAULT_KEY",
		"ART": preload("res://art/items/vault_key.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .25)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Cellar",
			"POSITION": Vector2(200, 200)
		},
		"INSPECT_TEXT": "Shiny set of keys. Just out of reach.",
		"INTERACTIONS": [
			{
				"LABEL": "Reach with Magnet",
				"SHOW_IF": func():
					return GameState.has_item("MAGNET"),
				"RESULT": func(item: ClickableItem):
					item.grab_action(item),
			}
		]
	},
	{
		"NAME": "MAGNET",
		"ART": preload("res://art/items/magnet.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .25)
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Cellar",
			"POSITION": Vector2(200, 400),
		},
		"INSPECT_TEXT": "Looks like a regular magnet.",
		"INTERACTIONS": []
	},
	{
		"NAME": "GEM",
		"ART": preload("res://art/items/gem.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.25, .25)
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Cellar",
			"POSITION": Vector2(200, 300),
			"HIDDEN": true
		},
		"INSPECT_TEXT": "This gem looks to be worth a hefty amount.",
		"INTERACTIONS": []
	},
	{
		"NAME": "WORST_AWARD",
		"ART": preload("res://art/items/worst_award.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Garage",
			"POSITION": Vector2(100, 600),
			"HIDDEN": true
		},
		"INSPECT_TEXT": "Shiny award for a distinguished engineer.",
		"INTERACTIONS": []
	},
	{
		"NAME": "BREAKER_PANEL",
		"ART": preload("res://art/items/breaker.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Garage",
			"POSITION": Vector2(600, 250),
		},
		"INSPECT_TEXT": "Unnecessarily complicated breaker panel.",
		"INTERACTIONS": [
			{
				"LABEL": "Fix",
				"SHOW_IF": func():
					return true,
				"RESULT": func(item: ClickableItem):
					GameState.change_room("BreakerPanel"),
			}
		]
	},
]

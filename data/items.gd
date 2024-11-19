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
	{
		"NAME": "EGGS",
		"ART": preload("res://art/items/eggs.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .25)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen",
			"POSITION": Vector2(600, 250),
		},
		"INSPECT_TEXT": "Eggs. Egg you glad I didn't say banana?",
		"INTERACTIONS": [
			{
				"LABEL": "Add to Cake Pan",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_PAN_OF_WATER_AND_CAKE_MIX"),
				"RESULT": func(item: ClickableItem):
					item.visible = false
					GameState.drop_item("CAKE_PAN_OF_WATER_AND_CAKE_MIX")
					GameState.grab_item("CAKE_PAN_OF_INGREDIENTS"),
			}
		]
	},
	{
		"NAME": "INSTANT_CAKE_MIX",
		"ART": preload("res://art/items/instant_cake_mix.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(1.0, .5)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen",
			"POSITION": Vector2(400, 250),
		},
		"INSPECT_TEXT": "Pigsbury Doughboy's instant cake mix.",
		"INTERACTIONS": [
			{
				"LABEL": "Add to Cake Pan",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_PAN_OF_WATER"),
				"RESULT": func(item: ClickableItem):
					item.visible = false
					GameState.drop_item("CAKE_PAN_OF_WATER")
					GameState.grab_item("CAKE_PAN_OF_WATER_AND_CAKE_MIX"),
			}
		]
	},
	{
		"NAME": "CAKE_PAN",
		"ART": preload("res://art/items/cake_pan.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Kitchen",
			"POSITION": Vector2(200, 250),
		},
		"INSPECT_TEXT": "A cake pan. May be used as an umbrella in emergencies.",
		"INTERACTIONS": []
	},
	{
		"NAME": "SINK",
		"ART": preload("res://art/items/sink.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .25)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen",
			"POSITION": Vector2(200, 450),
		},
		"INSPECT_TEXT": "Just a sink.",
		"INTERACTIONS": [
			{
				"LABEL": "Fill Cake Pan",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_PAN"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("CAKE_PAN")
					GameState.grab_item("CAKE_PAN_OF_WATER"),
			}
		]
	},
	{
		"NAME": "CAKE_PAN_OF_WATER",
		"INTERACTIONS": []
	},
	{
		"NAME": "CAKE_PAN_OF_WATER_AND_CAKE_MIX",
		"INTERACTIONS": []
	},
	{
		"NAME": "CAKE_PAN_OF_INGREDIENTS",
		"INTERACTIONS": []
	},
	{
		"NAME": "CAKE",
		"INTERACTIONS": []
	},
	{
		"NAME": "BURNT_CAKE",
		"INTERACTIONS": []
	},
	{
		"NAME": "OVEN",
		"ART": preload("res://art/items/oven.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .25)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen",
			"POSITION": Vector2(200, 650),
		},
		"INSPECT_TEXT": "So oven-like that it is undeniably an oven.",
		"INTERACTIONS": [
			{
				"LABEL": "Add Cake",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_PAN_OF_INGREDIENTS"),
				"RESULT": func(item: ClickableItem):
					GameState.start_oven()
					GameState.drop_item("CAKE_PAN_OF_INGREDIENTS"),
			},
			{
				"LABEL": "Remove Cake",
				"SHOW_IF": func():
					return GameState.oven.start_time != -1,
				"RESULT": func(item: ClickableItem):
					var time_elapsed = Time.get_ticks_msec() - GameState.oven.start_time
					if time_elapsed < 20000:
						GameState.grab_item("CAKE_PAN_OF_INGREDIENTS")
						GameState.stop_oven()
					elif time_elapsed < 40000:
						GameState.grab_item("CAKE")
						GameState.stop_oven()
					else:
						GameState.grab_item("BURNT_CAKE")
						GameState.stop_oven(),
			}
		]
	},
	{
		"NAME": "CAKE_RECIPE",
		"ART": preload("res://art/items/cake_recipe.png"),
		"SCALE": {
			"SPRITE": Vector2(1, 1),
			"COLLISION": Vector2(.5, .5)
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen",
			"POSITION": Vector2(400, 650),
		},
		"INSPECT_TEXT": "Pigsworth's famous cake recipe.",
		"INTERACTIONS": [
			{
				"LABEL": "Read",
				"SHOW_IF": func():
					return true,
				"RESULT": func(item: ClickableItem):
					GameState.change_room("CakeRecipe"),
			},
		]
	},
]

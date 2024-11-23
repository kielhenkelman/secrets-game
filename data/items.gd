extends Node

const ClickableItem = preload("res://clickable_item.gd")

var items = [
	{
		"NAME": "BUCKET",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/bucket.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/bucket_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/bucket_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/bucket.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Cellar"
		},
		"INSPECT_TEXT": "Looks like there could be something valueable inside.",
		"INTERACTIONS": []
	},
	{
		"NAME": "CAKE_TIN",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/cake_tin.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/cake_tin_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/cake_tin_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/cake_tin.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Kitchen",
		},
		"INSPECT_TEXT": "A cake tin.",
		"INTERACTIONS": []
	},
	{
		"NAME": "SINK",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/sink.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/sink_GLOW.png"),
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "Just a sink.",
		"INTERACTIONS": [
			{
				"LABEL": "Fill Cake Tin",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_TIN"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("CAKE_TIN")
					GameState.grab_item("CAKE_TIN_OF_WATER"),
			}
		]
	},
	{
		"NAME": "EGGS",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/eggs.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/eggs_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/eggs_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/eggs.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "Eggs. Egg you glad I didn't say banana?",
		"INTERACTIONS": [
			{
				"LABEL": "Add to Cake Tin",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_TIN_OF_WATER_AND_CAKE_MIX"),
				"RESULT": func(item: ClickableItem):
					item.visible = false
					GameState.drop_item("CAKE_TIN_OF_WATER_AND_CAKE_MIX")
					GameState.grab_item("CAKE_TIN_OF_INGREDIENTS"),
			}
		]
	},
	{
		"NAME": "INSTANT_CAKE_MIX",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/instant_cake_mix.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/instant_cake_mix_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/instant_cake_mix_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/instant_cake_mix.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen",
		},
		"INSPECT_TEXT": "Pigsbury Doughboy's instant cake mix.",
		"INTERACTIONS": [
			{
				"LABEL": "Add to Cake Tin",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_TIN_OF_WATER"),
				"RESULT": func(item: ClickableItem):
					item.visible = false
					GameState.drop_item("CAKE_TIN_OF_WATER")
					GameState.grab_item("CAKE_TIN_OF_WATER_AND_CAKE_MIX"),
			}
		]
	},
	{
		"NAME": "CAKE_TIN_OF_WATER",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake_tin_of_water.png")
		}
	},
	{
		"NAME": "CAKE_TIN_OF_WATER_AND_CAKE_MIX",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake_tin_of_water_and_cake_mix.png")
		}
	},
	{
		"NAME": "CAKE_TIN_OF_INGREDIENTS",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake_tin_of_ingredients.png")
		}
	},
	{
		"NAME": "CAKE",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake.png")
		}
	},
	{
		"NAME": "BURNT_CAKE",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/burnt_cake.png")
		}
	},
	{
		"NAME": "OVEN",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/oven.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/oven_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "So oven-like that it is undeniably an oven.",
		"INTERACTIONS": [
			{
				"LABEL": "Add Cake",
				"SHOW_IF": func():
					return GameState.has_item("CAKE_TIN_OF_INGREDIENTS"),
				"RESULT": func(item: ClickableItem):
					GameState.start_oven()
					GameState.drop_item("CAKE_TIN_OF_INGREDIENTS"),
			},
			{
				"LABEL": "Remove Cake",
				"SHOW_IF": func():
					return GameState.oven.start_time != -1,
				"RESULT": func(item: ClickableItem):
					var time_elapsed = Time.get_ticks_msec() - GameState.oven.start_time
					if time_elapsed < 20000:
						GameState.grab_item("CAKE_TIN_OF_INGREDIENTS")
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
]

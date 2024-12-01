extends Node

const ClickableItem = preload("res://clickable_item.gd")

var items = [
	{
		"NAME": "BREAKER",
		"DISPLAY_NAME": "Breaker",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/breaker_panel.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/breaker_panel_GLOW.png"),
		},
		"SPAWN": {
			"ROOM": "Garage"
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
		"NAME": "ELECTRICIAN_AWARD",
		"DISPLAY_NAME": "Worst Electrician Award",
		"VALUE": 1000000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/golden_worst_electrican_award.png"),
			"HIDDEN": preload("res://art/item_art_overlays/garage/golden_worst_electrican_award_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/golden_worst_electrican_award_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/worst_electrician_award.png")
		},
		"SIZE": "1x2",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Garage",
			"HIDDEN": true
		},
		"INSPECT_TEXT": "Shiny award for a distinguished engineer.",
		"INTERACTIONS": []
	},
	{
		"NAME": "BUCKET",
		"DISPLAY_NAME": "Bucket",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/bucket.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/bucket_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/bucket_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/bucket.png")
		},
		"SIZE": "1x2",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Cellar"
		},
		"INSPECT_TEXT": "Suitable as a helmet in a pinch.",
		"INTERACTIONS": []
	},
	{
		"NAME": "BUCKET_OF_WATER",
		"DISPLAY_NAME": "Bucket of Water",
		"VALUE": 1,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/bucket_of_water.png")
		},
		"SIZE": "1x2",
		"INTERACTIONS": []
	},
	{
		"NAME": "CAKE_TIN",
		"DISPLAY_NAME": "Cake Pan",
		"VALUE": 100,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/cake_tin.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/cake_tin_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/cake_tin_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/cake_tin.png")
		},
		"SIZE": "2x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Kitchen",
		},
		"INSPECT_TEXT": "A cake tin.",
		"INTERACTIONS": []
	},
	{
		"NAME": "SINK",
		"DISPLAY_NAME": "Sink",
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
			},
			{
				"LABEL": "Empty Bottle of Expensive Wine",
				"SHOW_IF": func():
					return GameState.has_item("BOTTLE_OF_EXPENSIVE_WINE"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("BOTTLE_OF_EXPENSIVE_WINE")
					GameState.grab_item("EMPTY_BOTTLE"),
			},
			{
				"LABEL": "Fill Bucket with Water",
				"SHOW_IF": func():
					return GameState.has_item("BUCKET"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("BUCKET")
					GameState.grab_item("BUCKET_OF_WATER"),
			}
		]
	},
	{
		"NAME": "EGGS",
		"DISPLAY_NAME": "Eggs",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/eggs.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/eggs_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/eggs_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/eggs.png")
		},
		"SIZE": "1x1",
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
					item.hide_item()
					GameState.drop_item("CAKE_TIN_OF_WATER_AND_CAKE_MIX")
					GameState.grab_item("CAKE_TIN_OF_INGREDIENTS"),
			}
		]
	},
	{
		"NAME": "INSTANT_CAKE_MIX",
		"DISPLAY_NAME": "Instant Cake Mix",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/instant_cake_mix.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/instant_cake_mix_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/instant_cake_mix_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/instant_cake_mix.png")
		},
		"SIZE": "1x1",
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
					item.hide_item()
					GameState.drop_item("CAKE_TIN_OF_WATER")
					GameState.grab_item("CAKE_TIN_OF_WATER_AND_CAKE_MIX"),
			}
		]
	},
	{
		"NAME": "CAKE_TIN_OF_WATER",
		"DISPLAY_NAME": "Cake Pan of Water",
		"VALUE": 100,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake_tin_of_water.png")
		}
	},
	{
		"NAME": "CAKE_TIN_OF_WATER_AND_CAKE_MIX",
		"DISPLAY_NAME": "Cake Pan of Water and Cake Mix",
		"VALUE": 100,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake_tin_of_water_and_cake_mix.png")
		}
	},
	{
		"NAME": "CAKE_TIN_OF_INGREDIENTS",
		"DISPLAY_NAME": "Cake Pan of Ingridients",
		"VALUE": 100,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake_tin_of_ingredients.png")
		}
	},
	{
		"NAME": "CAKE",
		"DISPLAY_NAME": "Cake",
		"VALUE": 100,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cake.png")
		}
	},
	{
		"NAME": "BURNT_CAKE",
		"DISPLAY_NAME": "Burnt Cake",
		"VALUE": 1,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/burnt_cake.png")
		}
	},
	{
		"NAME": "OVEN",
		"DISPLAY_NAME": "Oven",
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
					if not GameState.can_fit_item("CAKE"):
						GameState.popup_inventory_full()
						return
					
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
	{
		"NAME": "AXE",
		"DISPLAY_NAME": "Axe",
		"VALUE": 100,
		"SIZE": "3x1",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/axe.png"),
			"HIDDEN": preload("res://art/item_art_overlays/studio/axe_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/axe_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/axe.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Studio",
		},
		"INSPECT_TEXT": "This is axing for trouble.",
		"INTERACTIONS": []
	},
	{
		"NAME": "AXE_PAINTING",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/axe_painting.png"),
			"HIDDEN": preload("res://art/item_art_overlays/gallery/axe_painting_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/axe_painting_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Gallery",
		},
		"INSPECT_TEXT": "A painting of an axe, for some reason.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Axe",
				"SHOW_IF": func():
					return GameState.has_item("AXE"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("GOLDEN_AXE"):
						GameState.popup_inventory_full()
						return
					
					item.hide_item()
					GameState.grab_item("GOLDEN_AXE"),
			}
		]
	},
	{
		"NAME": "GOLDEN_AXE",
		"DISPLAY_NAME": "Golden Axe",
		"VALUE": 1000000,
		"SIZE": "3x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/golden_axe.png")
		},
	},
	{
		"NAME": "CAKE_PAINTING",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/cake_painting.png"),
			"HIDDEN": preload("res://art/item_art_overlays/gallery/cake_painting_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/cake_painting_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Gallery",
		},
		"INSPECT_TEXT": "A painting of a cake, for some reason.",
		"INTERACTIONS": [
			{
				"LABEL": "Throw Cake",
				"SHOW_IF": func():
					return GameState.has_item("CAKE"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("GOLDEN_CAKE"):
						GameState.popup_inventory_full()
						return
					
					item.hide_item()
					GameState.grab_item("GOLDEN_CAKE"),
			}
		]
	},
	{
		"NAME": "GOLDEN_CAKE",
		"DISPLAY_NAME": "Golden Cake",
		"VALUE": 4000000,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/golden_cake.png")
		},
	},
	{
		"NAME": "BOTTLE_OF_EXPENSIVE_WINE",
		"DISPLAY_NAME": "Bottle of Expensive Wine",
		"VALUE": 1000,
		"SIZE": "1x2",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/bottle_of_expensive_wine.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/bottle_of_expensive_wine_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/bottle_of_expensive_wine_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/bottle_of_expensive_wine.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Cellar",
		},
		"INSPECT_TEXT": "Some fancy-pants wine.",
		"INTERACTIONS": []
	},
	{
		"NAME": "EMPTY_BOTTLE",
		"DISPLAY_NAME": "Empty Bottle",
		"VALUE": 1,
		"SIZE": "1x2",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/empty_bottle.png")
		},
	},
	{
		"NAME": "BARREL_OF_REALLY_EXPENSIVE_WINE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/barrel_of_really_expensive_wine.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/barrel_of_really_expensive_wine_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Cellar",
		},
		"INSPECT_TEXT": "Some really fancy-pants wine.",
		"INTERACTIONS": [
			{
				"LABEL": "Fill Bottle",
				"SHOW_IF": func():
					return GameState.has_item("EMPTY_BOTTLE"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("EMPTY_BOTTLE")
					GameState.grab_item("BOTTLE_OF_REALLY_EXPENSIVE_WINE"),
			}
		]
	},
	{
		"NAME": "BOTTLE_OF_REALLY_EXPENSIVE_WINE",
		"DISPLAY_NAME": "Bottle of Really Expensive Wine",
		"VALUE": 100000,
		"SIZE": "1x2",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/bottle_of_really_expensive_wine.png")
		},
	},
	{
		"NAME": "HAMMER_AND_CHISEL",
		"DISPLAY_NAME": "Hammer and Chisel",
		"VALUE": 10,
		"SIZE": "1x1",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/hammer_and_chisel.png"),
			"HIDDEN": preload("res://art/item_art_overlays/garage/hammer_and_chisel_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/hammer_and_chisel_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/hammer_and_chisel.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Garage",
		},
		"INSPECT_TEXT": "Individually, a hammer and a chisel. Together, a hammer and chisel.",
		"INTERACTIONS": []
	},
	{
		"NAME": "EMBEDDED_AMETHYST",
		"DISPLAY_NAME": "Embedded Amethyst",
		"VALUE": 1000000,
		"SIZE": "1x1",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/embedded_amethyst.png"),
			"HIDDEN": preload("res://art/item_art_overlays/studio/embedded_amethyst_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/embedded_amethyst_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/embedded_amethyst.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Studio"
		},
		"INSPECT_TEXT": "A beautiful amethyst gemstone embedded in the table.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Hammer and Chisel",
				"SHOW_IF": func():
					return GameState.has_item("HAMMER_AND_CHISEL"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("EMBEDDED_AMETHYST"):
						GameState.popup_inventory_full()
						return
					item.hide_item()
					GameState.grab_item("EMBEDDED_AMETHYST"),
			}
		]
	},
	{
		"NAME": "EMBEDDED_PEARL",
		"DISPLAY_NAME": "Embedded Pearl",
		"VALUE": 1000000,
		"SIZE": "1x1",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/embedded_pearl.png"),
			"HIDDEN": preload("res://art/item_art_overlays/observatory/embedded_pearl_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/embedded_pearl_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/embedded_pearl.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Observatory"
		},
		"INSPECT_TEXT": "A beautiful pearl gemstone embedded in the telescope.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Hammer and Chisel",
				"SHOW_IF": func():
					return GameState.has_item("HAMMER_AND_CHISEL"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("EMBEDDED_PEARL"):
						GameState.popup_inventory_full()
						return
					item.hide_item()
					GameState.grab_item("EMBEDDED_PEARL"),
			}
		]
	},
	{
		"NAME": "EMBEDDED_GARNET",
		"DISPLAY_NAME": "Embedded Garnet",
		"VALUE": 1000000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/bedroom/embedded_garnet.png"),
			"HIDDEN": preload("res://art/item_art_overlays/bedroom/embedded_garnet_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/bedroom/embedded_garnet_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/embedded_garnet.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Bedroom"
		},
		"INSPECT_TEXT": "A beautiful garnet gemstone embedded in the desk.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Hammer and Chisel",
				"SHOW_IF": func():
					return GameState.has_item("HAMMER_AND_CHISEL"),
				"RESULT": func(item: ClickableItem):
					GameState.grab_item("EMBEDDED_GARNET"),
			}
		]
	},
	{
		"NAME": "EMBEDDED_SAPPHIRE",
		"DISPLAY_NAME": "Embedded Sapphire",
		"VALUE": 1000000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/office/embedded_sapphire.png"),
			"HIDDEN": preload("res://art/item_art_overlays/office/embedded_sapphire_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/office/embedded_sapphire_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/embedded_sapphire.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Office"
		},
		"INSPECT_TEXT": "A beautiful sapphire gemstone embedded in the desk.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Hammer and Chisel",
				"SHOW_IF": func():
					return GameState.has_item("HAMMER_AND_CHISEL"),
				"RESULT": func(item: ClickableItem):
					item.hide_item()
					GameState.grab_item("EMBEDDED_SAPPHIRE"),
			}
		]
	},
	{
		"NAME": "GRAND_PIANO",
		"DISPLAY_NAME": "Grand Piano",
		"VALUE": 700000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/grand_piano.png"),
			"HIDDEN": preload("res://art/item_art_overlays/studio/grand_piano_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/grand_piano_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/grand_piano.png")
		},
		"SIZE": "3x4",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Studio",
		},
		"INSPECT_TEXT": "A grand piano. Somehow I think I can carry this.",
		"INTERACTIONS": []
	},
	{
		"NAME": "SILVER_CANE",
		"DISPLAY_NAME": "Silver Cane",
		"VALUE": 100000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/silver_cane.png"),
			"HIDDEN": preload("res://art/item_art_overlays/gallery/silver_cane_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/silver_cane_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/silver_cane.png")
		},
		"SIZE": "1x3",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Gallery",
		},
		"INSPECT_TEXT": "A silver walking cane.",
		"INTERACTIONS": []
	},
	{
		"NAME": "MULTITOOL",
		"DISPLAY_NAME": "Multitool",
		"VALUE": 10,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/multitool.png"),
			"HIDDEN": preload("res://art/item_art_overlays/garage/multitool_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/multitool_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/multitool.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Garage",
		},
		"INSPECT_TEXT": "A multitool. More pointy edges than I can count.",
		"INTERACTIONS": []
	},
	{
		"NAME": "DISHWASHER",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/dishwasher.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/dishwasher_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen",
		},
		"INSPECT_TEXT": "A dishwasher. I wonder what's inside?",
		"INTERACTIONS": [
			{
				"LABEL": "Open",
				"RESULT": func(item: ClickableItem):
					GameState.popup("It's jammed shut. I'll need something to help me pry it open."),
			},
			{
				"LABEL": "Use Multitool",
				"SHOW_IF": func():
					return GameState.has_item("MULTITOOL"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("SILVER_PLATES"):
						GameState.popup_inventory_full()
						return
					
					item.clickable = false
					GameState.grab_item("SILVER_PLATES"),
			}
		]
	},
	{
		"NAME": "SILVER_PLATES",
		"DISPLAY_NAME": "Silver Plates",
		"VALUE": 100000,
		"SIZE": "1x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/silver_plates.png")
		},
	},
	{
		"NAME": "RUBBER_GRABBER",
		"DISPLAY_NAME": "Rubber Grabber",
		"VALUE": 50000,
		"SIZE": "1x3",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/rubber_grabber.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/rubber_grabber_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/rubber_grabber_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/rubber_grabber.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "A grabber conveniently made of rubber.",
		"INTERACTIONS": []
	},
	{
		"NAME": "OPAL",
		"DISPLAY_NAME": "Opal",
		"VALUE": 1000000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/opal.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/opal_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/opal_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/opal.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Cellar"
		},
		"INSPECT_TEXT": "A beautiful opal gemstone.",
		"INTERACTIONS": [
			{
				"LABEL": "Reach",
				"RESULT": func(item: ClickableItem):
					GameState.popup("It's behind an electrified grate. There's no way I'm getting it with my bare hands."),
			},
			{
				"LABEL": "Use Rubber Grabber",
				"SHOW_IF": func():
					return GameState.has_item("RUBBER_GRABBER"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("OPAL"):
						GameState.popup_inventory_full()
						return
					item.hide_item()
					GameState.grab_item("OPAL"),
			}
		]
	},
	{
		"NAME": "LADDER",
		"DISPLAY_NAME": "Ladder",
		"VALUE": 100,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/ladder.png"),
			"HIDDEN": preload("res://art/item_art_overlays/garage/ladder_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/ladder_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/ladder.png")
		},
		"SIZE": "1x4",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Garage"
		},
		"INSPECT_TEXT": "A ladder. Remember to take basic safety precautions!",
		"INTERACTIONS": []
	},
	{
		"NAME": "BLACK_PUZZLE_PIECE",
		"DISPLAY_NAME": "Black Puzzle Piece",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/black_puzzle_piece.png"),
			"HIDDEN": preload("res://art/item_art_overlays/garage/black_puzzle_piece_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/black_puzzle_piece_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/black_puzzle_piece.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Garage"
		},
		"INSPECT_TEXT": "A black puzzle piece",
		"INTERACTIONS": []
	},
	{
		"NAME": "YELLOW_PUZZLE_PIECE",
		"DISPLAY_NAME": "Yellow Puzzle Piece",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/yellow_puzzle_piece.png"),
			"HIDDEN": preload("res://art/item_art_overlays/studio/yellow_puzzle_piece_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/yellow_puzzle_piece_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/yellow_puzzle_piece.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Studio"
		},
		"INSPECT_TEXT": "A yellow puzzle piece",
		"INTERACTIONS": []
	},
	{
		"NAME": "WHITE_PUZZLE_PIECE",
		"DISPLAY_NAME": "White Puzzle Piece",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/white_puzzle_piece.png"),
			"HIDDEN": preload("res://art/item_art_overlays/observatory/white_puzzle_piece_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/white_puzzle_piece_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/white_puzzle_piece.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Observatory"
		},
		"INSPECT_TEXT": "A white puzzle piece",
		"INTERACTIONS": []
	},
	{
		"NAME": "BLUE_PUZZLE_PIECE",
		"DISPLAY_NAME": "Blue Puzzle Piece",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/bedroom/blue_puzzle_piece.png"),
			"HIDDEN": preload("res://art/item_art_overlays/bedroom/blue_puzzle_piece_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/bedroom/blue_puzzle_piece_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/blue_puzzle_piece.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Bedroom"
		},
		"INSPECT_TEXT": "A blue puzzle piece",
		"INTERACTIONS": []
	},
	{
		"NAME": "ABSTRACT_ART",
		"DISPLAY_NAME": "Absract Art",
		"VALUE": 5000000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/bedroom/abstract_art.png"),
			"HIDDEN": preload("res://art/item_art_overlays/bedroom/abstract_art_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/bedroom/abstract_art_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/abstract_art.png")
		},
		"SIZE": "2x2",
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Bedroom"
		},
		"INSPECT_TEXT": "This painting has some pieces missing, like me.",
		"INTERACTIONS": [
			{
				"LABEL": "Add Puzzle Pieces & Take",
				"SHOW_IF": func():
					return (GameState.has_item("BLACK_PUZZLE_PIECE") &&
						GameState.has_item("YELLOW_PUZZLE_PIECE") &&
						GameState.has_item("WHITE_PUZZLE_PIECE") &&
						GameState.has_item("BLUE_PUZZLE_PIECE")),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("ABSTRACT_ART"):
						GameState.popup_inventory_full()
						return
					
					item.hide_item()
					GameState.drop_item("BLACK_PUZZLE_PIECE")
					GameState.drop_item("YELLOW_PUZZLE_PIECE")
					GameState.drop_item("WHITE_PUZZLE_PIECE")
					GameState.drop_item("BLUE_PUZZLE_PIECE")
					GameState.grab_item("ABSTRACT_ART"),
			}
		]
	},
	{
		"NAME": "KNIFE",
		"DISPLAY_NAME": "Knife",
		"VALUE": 10,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/knife.png"),
			"HIDDEN": preload("res://art/item_art_overlays/gallery/knife_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/knife_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/knife.png")
		},
		"SIZE": "2x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Gallery"
		},
		"INSPECT_TEXT": "Pointy and good for stabbing.",
		"INTERACTIONS": []
	},
	{
		"NAME": "TURQUOISE_PAINTED_KNIFE",
		"DISPLAY_NAME": "Turquoise Knife",
		"VALUE": 10,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/turquoise_painted_knife.png")
		}
	},
	{
		"NAME": "TURQUOISE_PAINTED_GEM",
		"DISPLAY_NAME": "Turquoise Gem",
		"VALUE": 1000000,
		"SIZE": "1x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/turqoise_painted_gemstone.png")
		}
	},
	{
		"NAME": "TROUGH_OF_TURQUOISE_PAINT",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/trough_of_turquoise_paint.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/trough_of_turquoise_paint_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Conservatory"
		},
		"INSPECT_TEXT": "A trough of turquoise paint.",
		"INTERACTIONS": [
			{
				"LABEL": "Dip Knife",
				"SHOW_IF": func():
					return GameState.has_item("KNIFE"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("KNIFE")
					GameState.grab_item("TURQUOISE_PAINTED_KNIFE"),
			},
			{
				"LABEL": "Dip Great Diamond of Pigsylvania",
				"SHOW_IF": func():
					return GameState.has_item("GREAT_DIAMOND_OF_PIGSYLVANIA"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("GREAT_DIAMOND_OF_PIGSYLVANIA")
					GameState.grab_item("TURQUOISE_PAINTED_GEM"),
			},
			{
				"LABEL": "Dip Opal",
				"SHOW_IF": func():
					return GameState.has_item("OPAL"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("OPAL")
					GameState.grab_item("TURQUOISE_PAINTED_GEM"),
			},
			{
				"LABEL": "Dip Ruby",
				"SHOW_IF": func():
					return GameState.has_item("RUBY"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("RUBY")
					GameState.grab_item("TURQUOISE_PAINTED_GEM"),
			},
			{
				"LABEL": "Dip Embedded Amethyst",
				"SHOW_IF": func():
					return GameState.has_item("EMBEDDED_AMETHYST"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("EMBEDDED_AMETHYST")
					GameState.grab_item("TURQUOISE_PAINTED_GEM"),
			},
			{
				"LABEL": "Dip Embedded Garnet",
				"SHOW_IF": func():
					return GameState.has_item("EMBEDDED_GARNET"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("EMBEDDED_GARNET")
					GameState.grab_item("TURQUOISE_PAINTED_GEM"),
			},
			{
				"LABEL": "Dip Embedded Pearl",
				"SHOW_IF": func():
					return GameState.has_item("EMBEDDED_PEARL"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("EMBEDDED_PEARL")
					GameState.grab_item("TURQUOISE_PAINTED_GEM"),
			},
			{
				"LABEL": "Dip Embedded Sapphire",
				"SHOW_IF": func():
					return GameState.has_item("EMBEDDED_SAPPHIRE"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("EMBEDDED_SAPPHIRE")
					GameState.grab_item("TURQUOISE_PAINTED_GEM"),
			},
		]
	},
	{
		"NAME": "GOLDEN_KNIFE",
		"DISPLAY_NAME": "Golden Knife",
		"VALUE": 1000000,
		"SIZE": "2x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/golden_knife.png")
		}
	},
	{
		"NAME": "KNIFE_PAINTING",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/knife_painting.png"),
			"HIDDEN": preload("res://art/item_art_overlays/gallery/knife_painting_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/knife_painting_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Gallery",
		},
		"INSPECT_TEXT": "A painting of a knife, for some reason.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Knife",
				"SHOW_IF": func():
					return GameState.has_item("KNIFE"),
				"RESULT": func(item: ClickableItem):
					GameState.popup('The painting is impervious to this incorrectly-colored knife.'),
			},
			{
				"LABEL": "Use Turquoise Painted Knife",
				"SHOW_IF": func():
					return GameState.has_item("TURQUOISE_PAINTED_KNIFE"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("GOLDEN_KNIFE"):
						GameState.popup_inventory_full()
						return
					item.hide_item()
					GameState.grab_item("GOLDEN_KNIFE"),
			}
		]
	},
	{
		"NAME": "LARGE_JAR_OF_SAFFRON",
		"DISPLAY_NAME": "Large Jar of Saffron",
		"VALUE": 100000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/large_jar_of_saffron.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/large_jar_of_saffron_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/large_jar_of_saffron_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/large_jar_of_saffron.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "A large jar of saffron.",
		"INTERACTIONS": []
	},
	{
		"NAME": "VINTAGE_CIGAR_BOX",
		"DISPLAY_NAME": "Vintage Cigar Box",
		"VALUE": 100000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/office/vintage_cigar_box.png"),
			"HIDDEN": preload("res://art/item_art_overlays/office/vintage_cigar_box_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/office/vintage_cigar_box_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/vintage_cigar_box.png")
		},
		"SIZE": "2x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Office"
		},
		"INSPECT_TEXT": "A box of vintage cigars.",
		"INTERACTIONS": []
	},
	{
		"NAME": "SHOVEL",
		"DISPLAY_NAME": "Shovel",
		"VALUE": 10,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/shovel.png"),
			"HIDDEN": preload("res://art/item_art_overlays/garage/shovel_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/shovel_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/shovel.png")
		},
		"SIZE": "3x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Garage"
		},
		"INSPECT_TEXT": "A shovel. May be used for bludgeoning, or for digging if you're boring like that.",
		"INTERACTIONS": []
	},
	{
		"NAME": "ODD_PATCH_OF_DIRT",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/odd_patch_of_dirt.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/odd_patch_of_dirt_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Conservatory"
		},
		"INSPECT_TEXT": "An odd patch of dirt. Notably, not even.",
		"INTERACTIONS": [
			{
				"LABEL": "Dig with Shovel",
				"SHOW_IF": func():
					return GameState.has_item("SHOVEL"),
				"RESULT": func(item: ClickableItem):
					if not GameState.can_fit_item("TREASURE"):
						GameState.popup_inventory_full()
						return
					item.hide_item()
					GameState.grab_item("TREASURE"),
			},
		]
	},
	{
		"NAME": "TREASURE",
		"DISPLAY_NAME": "Treasure",
		"VALUE": 2000000,
		"SIZE": "1x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/treasure.png")
		}
	},
	{
		"NAME": "DIARY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/bedroom/diary.png"),
			"GLOW": preload("res://art/item_art_overlays/bedroom/diary_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Bedroom"
		},
		"INSPECT_TEXT": "Looks like a diary. It would be highly unethical to read this.",
		"INTERACTIONS": [
			{
				"LABEL": "Read",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Diary'),
			},
		]
	},
	{
		"NAME": "RED_BRICK",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/red_brick.png"),
			"HIDDEN": preload("res://art/item_art_overlays/conservatory/red_brick_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/red_brick_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Conservatory"
		},
		"INSPECT_TEXT": "This brick seems suspicious.",
		"INTERACTIONS": [
			{
				"LABEL": "Check",
				"RESULT": func(item: ClickableItem):
					item.hide_item()
					GameState.grab_item("RUBY"),
			},
		]
	},
	{
		"NAME": "RUBY",
		"DISPLAY_NAME": "Ruby",
		"VALUE": 1000000,
		"SIZE": "1x1",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/ruby.png")
		}
	},
	{
		"NAME": "MAGIC_EIGHT_BALL",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/office/magic_eight_ball.png"),
			"GLOW": preload("res://art/item_art_overlays/office/magic_eight_ball_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Office"
		},
		"INSPECT_TEXT": "A Magic 8 Ball.",
		"INTERACTIONS": [
			{
				"LABEL": "Look Into",
				"RESULT": func(item: ClickableItem):
					var random = Time.get_ticks_msec() % 2
					if random == 0:
						GameState.popup('"CONSERVATORY"')
					else:
						GameState.popup('"HIGH BRICK"'),
			},
		]
	},
	{
		"NAME": "ANTIQUE_FIGURINES",
		"DISPLAY_NAME": "Antique Figurines",
		"VALUE": 2000000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/attic/antique_figurines.png"),
			"HIDDEN": preload("res://art/item_art_overlays/attic/antique_figurines_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/attic/antique_figurines_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/antique_figurines.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Attic"
		},
		"INSPECT_TEXT": "Antique figurines.",
		"INTERACTIONS": []
	},
	{
		"NAME": "ANTIQUE_TYPEWRITER",
		"DISPLAY_NAME": "Antique Typewriter",
		"VALUE": 50000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/attic/antique_typewriter.png"),
			"HIDDEN": preload("res://art/item_art_overlays/attic/antique_typewriter_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/attic/antique_typewriter_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/antique_typewriter.png")
		},
		"SIZE": "2x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Attic"
		},
		"INSPECT_TEXT": "An antique typewriter.",
		"INTERACTIONS": []
	},
	{
		"NAME": "ANTIQUE_RUG",
		"DISPLAY_NAME": "Antique Rug",
		"VALUE": 100000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/attic/rug.png"),
			"HIDDEN": preload("res://art/item_art_overlays/attic/rug_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/attic/rug_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/antique_rug.png")
		},
		"SIZE": "1x4",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Attic"
		},
		"INSPECT_TEXT": "An antique rug.",
		"INTERACTIONS": []
	},
	{
		"NAME": "ANTIQUE_JEWELRY_BOX",
		"DISPLAY_NAME": "Antique Jewelry Box",
		"VALUE": 1000000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/attic/jewelry_box.png"),
			"HIDDEN": preload("res://art/item_art_overlays/attic/jewelry_box_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/attic/jewelry_box_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/jewelry_box.png")
		},
		"SIZE": "2x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Attic"
		},
		"INSPECT_TEXT": "An antique rug.",
		"INTERACTIONS": []
	},
	{
		"NAME": "RECIPE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/recipe.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/recipe_GLOW.png")
		},
		"SIZE": "2x1",
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "Looks like a recipe. I should read it.",
		"INTERACTIONS": [
			{
				"LABEL": "Read",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('CakeRecipe'),
			},
		]
	},
	{
		"NAME": "WET_CLAY",
		"DISPLAY_NAME": "Wet Clay",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/wet_clay.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/wet_clay_GLOW.png"),
			"HIDDEN": preload("res://art/item_art_overlays/conservatory/wet_clay_GONE.png"),
			"ICON": preload("res://art/inventory_icons/soft_clay.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Conservatory"
		},
		"INSPECT_TEXT": "Some wet clay.",
		"INTERACTIONS": []
	},
	{
		"NAME": "GREY_KEY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/grey_key.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/grey_key_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Conservatory"
		},
		"INSPECT_TEXT": "A key attached to a chain. I can't remove it.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Wet Clay",
				"SHOW_IF": func():
					return GameState.has_item("WET_CLAY"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("WET_CLAY")
					GameState.grab_item("KEY_MOULD"),
			}
		]
	},
	{
		"NAME": "KEY_MOULD",
		"DISPLAY_NAME": "Key Mould",
		"SIZE": "1x1",
		"VALUE": 1,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/key_mould.png")
		},
		"INTERACTIONS": []
	},
	{
		"NAME": "BAG_OF_CEMENT",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/bag_of_cement.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/bag_of_cement_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Conservatory"
		},
		"INSPECT_TEXT": "A bag of quick-dry cement.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Key Mould",
				"SHOW_IF": func():
					return GameState.has_item("KEY_MOULD"),
				"RESULT": func(item: ClickableItem):
					GameState.drop_item("KEY_MOULD")
					GameState.grab_item("CEMENT_KEY"),
			}
		]
	},
	{
		"NAME": "CEMENT_KEY",
		"DISPLAY_NAME": "Cement Key",
		"SIZE": "1x1",
		"VALUE": 1,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/cement_key.png")
		},
		"INTERACTIONS": []
	},
	{
		"NAME": "GREY_SAFE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/grey_safe.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/grey_safe_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Conservatory"
		},
		"INSPECT_TEXT": "A safe. I wonder where the key is?",
		"INTERACTIONS": [
			{
				"LABEL": "Use Cement Key",
				"SHOW_IF": func():
					return GameState.has_item("CEMENT_KEY"),
				"RESULT": func(item: ClickableItem):
					item.clickable = false
					GameState.drop_item("CEMENT_KEY")
					GameState.grab_item("GREAT_DIAMOND_OF_PIGSYLVANIA"),
			}
		]
	},
	{
		"NAME": "GREAT_DIAMOND_OF_PIGSYLVANIA",
		"DISPLAY_NAME": "Great Diamond of Pigsylvania",
		"SIZE": "1x1",
		"VALUE": 10000000,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/great_diamond_of_pigsylvania.png")
		},
		"INTERACTIONS": []
	},
	{
		"NAME": "SILVER_SALT_SHAKER",
		"DISPLAY_NAME": "Silver Salt Shaker",
		"VALUE": 10000,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/silver_salt_shaker.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/silver_salt_shaker_GLOW.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/silver_salt_shaker_GONE.png"),
			"ICON": preload("res://art/inventory_icons/silver_salt_shaker.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "An unnecessarily expensive salt shaker.",
		"INTERACTIONS": []
	},
	{
		"NAME": "MAGNET",
		"DISPLAY_NAME": "Magnet",
		"VALUE": 10,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/magnet.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/magnet_GLOW.png"),
			"HIDDEN": preload("res://art/item_art_overlays/observatory/magnet_GONE.png"),
			"ICON": preload("res://art/inventory_icons/magnet.png")
		},
		"SIZE": "1x2",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Observatory"
		},
		"INSPECT_TEXT": "Just a magent left unattended.",
		"INTERACTIONS": []
	},
	{
		"NAME": "RED_KEY",
		"DISPLAY_NAME": "Red Key",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/red_key.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/red_key_GLOW.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/red_key_GONE.png"),
			"ICON": preload("res://art/inventory_icons/red_key.png")
		},
		"SIZE": "1x1",
		"SPAWN": {
			"ROOM": "Cellar"
		},
		"INSPECT_TEXT": "This metal key is hard to reach, if only there was a magent...",
		"INTERACTIONS": [
			{
				"LABEL": "Grab with Magenet",
				"SHOW_IF": func():
					return GameState.has_item("MAGNET"),
				"RESULT": func(item: ClickableItem):
					GameState.grab_item("RED_KEY"),
			}
		]
	},
	{
		"NAME": "GEODE",
		"DISPLAY_NAME": "Geode",
		"VALUE": 1000000,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/geode.png")
		},
		"SIZE": "1x1",
		"INTERACTIONS": []
	},
	{
		"NAME": "RED_VAULT",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/red_vault.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/red_vault_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Cellar"
		},
		"INSPECT_TEXT": "A red vault.",
		"INTERACTIONS": [
			{
				"LABEL": "Open Vault",
				"RESULT": func(item: ClickableItem):
					if GameState.has_item("RED_KEY"):
						GameState.drop_item("RED_KEY")
						GameState.grab_item("GEODE")
					else:
						GameState.popup("Missing a red key"),
			}
		]
	},
	{
		"NAME": "TELESCOPE_LEFT",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/telescope_2.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/telescope_2_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Observatory"
		},
		"INSPECT_TEXT": "A telescope.",
		"INTERACTIONS": [
			{
				"LABEL": "Look-through",
				"RESULT": func(item: ClickableItem):
					GameState.change_room("TelescopeLeft"),
			}
		]
	},
	{
		"NAME": "TELESCOPE_RIGHT",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/telescope_1.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/telescope_1_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Observatory"
		},
		"INSPECT_TEXT": "A telescope.",
		"INTERACTIONS": [
			{
				"LABEL": "Look-through",
				"RESULT": func(item: ClickableItem):
					GameState.change_room("TelescopeRight"),
			}
		]
	},
	{
		"NAME": "TERMINAL",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/terminal.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/terminal_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Observatory"
		},
		"INSPECT_TEXT": "A terminal.",
		"INTERACTIONS": [
			{
				"LABEL": "Read",
				"RESULT": func(item: ClickableItem):
					GameState.popup("SYSTEM CALIBRATION: Point one telescope at Aries and one telescope at Pisces to unlock drawer.", 6),
			}
		]
	},
	{
		"NAME": "DRAWER",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/drawer.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/drawer_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Observatory"
		},
		"INSPECT_TEXT": "A drawer.",
		"INTERACTIONS": [
			{
				"LABEL": "Open",
				"RESULT": func(item: ClickableItem):
					const ARIES = 0
					const PISCES = 11
					
					var aries_pointed_at = GameState.telescope_left == ARIES || GameState.telescope_right == ARIES
					var pisces_pointed_at = GameState.telescope_left == PISCES || GameState.telescope_right == PISCES
					var puzzle_solved = aries_pointed_at && pisces_pointed_at
					
					if puzzle_solved:
						if GameState.can_fit_item("CRYSTAL_LENS"):
							GameState.grab_item("CRYSTAL_LENS")
							GameState.popup("Received Crystal Lens.")
							item.clickable = false
						else:
							GameState.popup_inventory_full()
					else:
						GameState.popup("It's locked shut.", 3),
			}
		]
	},
	{
		"NAME": "CRYSTAL_LENS",
		"DISPLAY_NAME": "Crystal Lens",
		"SIZE": "1x1",
		"VALUE": 5000000,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/crystal_lens.png")
		},
		"INTERACTIONS": []
	},
	{
		"NAME": "CAULDRON_NOTE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/note.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/note_GLOW.png"),
		},
		"SPAWN": {
			"ROOM": "Cellar"
		},
		"INSPECT_TEXT": "An old note with an odd recipe.",
		"INTERACTIONS": [
			{
				"LABEL": "Read",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('CauldronRecipe'),
			},
		]
	},
	{
		"NAME": "BREAD",
		"DISPLAY_NAME": "Bread",
		"VALUE": 1,
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/bread.png"),
			"HIDDEN": preload("res://art/item_art_overlays/kitchen/bread_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/bread_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/bread.png")
		},
		"SIZE": "1x1",
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Kitchen"
		},
		"INSPECT_TEXT": "A loaf of bread. Regular kind.",
		"INTERACTIONS": []
	},
	{
		"NAME": "TURQUOISE_GEM",
		"DISPLAY_NAME": "Turquoise-Painted Gem",
		"VALUE": 1000000,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/turqoise_painted_gemstone.png")
		},
		"SIZE": "1x1",
		"INTERACTIONS": []
	},
	{
		"NAME": "DIAMOND_ORB",
		"DISPLAY_NAME": "Diamond Orb",
		"VALUE": 10000000,
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/diamond_orb.png")
		},
		"SIZE": "1x1",
		"INTERACTIONS": []
	},
	{
		"NAME": "CAULDRON",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/cauldron.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/cauldron_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Cellar"
		},
		"INSPECT_TEXT": "An evil looking cauldron.",
		"INTERACTIONS": [
			{
				"LABEL": "Perform Ritual",
				"SHOW_IF": func():
					return true,
				"RESULT": func(item: ClickableItem):
					if GameState.has_item("BREAD") \
							and GameState.has_item("BUCKET_OF_WATER") \
							and GameState.has_item("SILVER_SALT_SHAKER") \
							and GameState.has_item("TURQUOISE_PAINTED_GEM"):
						GameState.drop_item("BUCKET_OF_WATER")
						GameState.drop_item("BREAD")
						GameState.drop_item("TURQUOISE_PAINTED_GEM")
						GameState.grab_item("DIAMOND_ORB")
					else:
						GameState.popup("You're missing some ingredients."),
			}
		]
	},

	## DOORS ##
	{
		"NAME": "CELLAR_TO_GARAGE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/stairs_to_garage.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/stairs_to_garage_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Cellar" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Garage",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Garage'),
			}
		],
	},
	{
		"NAME": "GARAGE_TO_CELLAR",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/trapdoor_to_cellar.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/trapdoor_to_cellar_GLOW.png"),
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Garage" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Cellar",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Cellar'),
			}
		],
	},
	{
		"NAME": "GARAGE_TO_GALLERY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/door_to_gallery.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/door_to_gallery_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Garage" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Gallery",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Gallery'),
			}
		],
	},
	{
		"NAME": "GALLERY_TO_STUDIO",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/door_to_studio.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/door_to_studio_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Gallery" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Studio",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Studio'),
			}
		],
	},
	{
		"NAME": "GALLERY_TO_GARAGE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/door_to_garage.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/door_to_garage_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Gallery" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Garage",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Garage'),
			}
		],
	},
	{
		"NAME": "STUDIO_TO_KITCHEN",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/door_to_kitchen.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/door_to_kitchen_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Studio" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Kitchen",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Kitchen'),
			}
		],
	},
	{
		"NAME": "STUDIO_TO_GALLERY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/door_to_gallery.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/door_to_gallery_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Studio" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Gallery",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Gallery'),
			}
		],
	},
	{
		"NAME": "KITCHEN_TO_STUDIO",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/kitchen/door_to_studio.png"),
			"GLOW": preload("res://art/item_art_overlays/kitchen/door_to_studio_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Kitchen" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Studio",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Studio'),
			}
		],
	},
	{
		"NAME": "STUDIO_TO_OBSERVATORY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/stairs_to_observatory.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/stairs_to_observatory_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Studio" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Observatory",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Observatory'),
			}
		],
	},
	{
		"NAME": "OBSERVATORY_TO_STUDIO",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/stairs_to_studio.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/stairs_to_studio_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Observatory", "ALWAYS_HIGHLIGHT": true },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Studio",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Studio'),
			}
		],
	},
	{
		"NAME": "OBSERVATORY_TO_CONSERVATORY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/observatory/door_to_conservatory.png"),
			"GLOW": preload("res://art/item_art_overlays/observatory/door_to_conservatory_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Observatory" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Conservatory",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Conservatory'),
			}
		],
	},
	{
		"NAME": "CONSERVATORY_TO_OBSERVATORY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/door_to_observatory.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/door_to_observatory_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Conservatory" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Observatory",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Observatory'),
			}
		],
	},
	{
		"NAME": "CONSERVATORY_TO_OFFICE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/door_to_office.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/door_to_office_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Conservatory" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Office",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Office'),
			}
		],
	},
	{
		"NAME": "CONSERVATORY_TO_BEDROOM",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/conservatory/door_to_bedroom.png"),
			"GLOW": preload("res://art/item_art_overlays/conservatory/door_to_bedroom_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Conservatory" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Bedroom",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Bedroom'),
			}
		],
	},
	{
		"NAME": "OFFICE_TO_CONSERVATORY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/office/door_to_conservatory.png"),
			"GLOW": preload("res://art/item_art_overlays/office/door_to_conservatory_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Office" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Conservatory",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Conservatory'),
			}
		],
	},
	{
		"NAME": "BEDROOM_TO_CONSERVATORY",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/bedroom/door_to_conservatory.png"),
			"GLOW": preload("res://art/item_art_overlays/bedroom/door_to_conservatory_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Bedroom" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Conservatory",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Conservatory'),
			}
		],
	},
	{
		"NAME": "BEDROOM_TO_ATTIC",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/bedroom/trapdoor_to_attic.png"),
			"GLOW": preload("res://art/item_art_overlays/bedroom/trapdoor_to_attic_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Bedroom" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Attic",
				"RESULT": func(item: ClickableItem):
					if GameState.has_item('LADDER'):
						GameState.change_room('Attic')
					else:
						GameState.popup('I will need something to help me reach that.'),
			}
		],
	},
	{
		"NAME": "ATTIC_TO_BEDROOM",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/attic/trapdoor_to_bedroom.png"),
			"GLOW": preload("res://art/item_art_overlays/attic/trapdoor_to_bedroom_GLOW.png")
		},
		"CAN_GRAB": false,
		"SPAWN": { "ROOM": "Attic" },
		"INTERACTIONS": [
			{
				"LABEL": "Go to Bedroom",
				"RESULT": func(item: ClickableItem):
					GameState.change_room('Bedroom'),
			}
		],
	},
]

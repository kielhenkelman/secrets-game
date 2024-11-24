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
					item.hide_item()
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
					item.hide_item()
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
	{
		"NAME": "AXE",
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
					item.hide_item()
					GameState.grab_item("GOLDEN_AXE"),
			}
		]
	},
	{
		"NAME": "GOLDEN_AXE",
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
					item.hide_item()
					GameState.grab_item("GOLDEN_CAKE"),
			}
		]
	},
	{
		"NAME": "GOLDEN_CAKE",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/golden_cake.png")
		},
	},
	{
		"NAME": "BOTTLE_OF_EXPENSIVE_WINE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/bottle_of_expensive_wine.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/bottle_of_expensive_wine_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/bottle_of_expensive_wine_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/bottle_of_expensive_wine.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Cellar",
		},
		"INSPECT_TEXT": "Some fancy-pants wine.",
		"INTERACTIONS": [
			{
				"LABEL": "Empty & Take",
				"RESULT": func(item: ClickableItem):
					item.hide_item()
					GameState.grab_item("EMPTY_BOTTLE"),
			}			
		]
	},
	{
		"NAME": "EMPTY_BOTTLE",
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
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/bottle_of_really_expensive_wine.png")
		},
	},
	{
		"NAME": "HAMMER_AND_CHISEL",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/hammer_and_chisel.png"),
			"GONE": preload("res://art/item_art_overlays/garage/hammer_and_chisel_GONE.png"),
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
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/embedded_amethyst.png"),
			"GONE": preload("res://art/item_art_overlays/studio/embedded_amethyst_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/embedded_amethyst_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/embedded_amethyst.png")
		},
		"CAN_GRAB": false,
		"SPAWN": {
			"ROOM": "Studio"
		},
		"INSPECT_TEXT": "A beautiful amethyst gem.",
		"INTERACTIONS": [
			{
				"LABEL": "Use Hammer and Chisel",
				"SHOW_IF": func():
					return GameState.has_item("HAMMER_AND_CHISEL"),
				"RESULT": func(item: ClickableItem):
					item.hide_item()
					GameState.grab_item("EMBEDDED_AMETHYST"),
			}
		]
	},
	{
		"NAME": "GRAND_PIANO",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/studio/grand_piano.png"),
			"HIDDEN": preload("res://art/item_art_overlays/studio/grand_piano_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/studio/grand_piano_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/grand_piano.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Studio",
		},
		"INSPECT_TEXT": "A grand piano. Somehow I think I can carry this.",
		"INTERACTIONS": []
	},
	{
		"NAME": "SILVER_CANE",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/gallery/silver_cane.png"),
			"HIDDEN": preload("res://art/item_art_overlays/gallery/silver_cane_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/gallery/silver_cane_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/silver_cane.png")
		},
		"CAN_GRAB": true,
		"SPAWN": {
			"ROOM": "Gallery",
		},
		"INSPECT_TEXT": "A silver walking cane.",
		"INTERACTIONS": []
	},
	{
		"NAME": "MULTITOOL",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/garage/multitool.png"),
			"HIDDEN": preload("res://art/item_art_overlays/garage/multitool_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/garage/multitool_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/multitool.png")
		},
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
					item.clickable = false
					GameState.grab_item("SILVER_PLATES"),
			}
		]
	},
	{
		"NAME": "SILVER_PLATES",
		"TEXTURE": {
			"ICON": preload("res://art/inventory_icons/silver_plates.png")
		},
	},
	{
		"NAME": "RUBBER_GRABBER",
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
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/opal.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/opal_GONE.png"),
			"GLOW": preload("res://art/item_art_overlays/cellar/opal_GLOW.png"),
			"ICON": preload("res://art/inventory_icons/opal.png")
		},
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
					item.hide_item()
					GameState.grab_item("OPAL"),
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
	}
]

extends Node

const ClickableItem = preload("res://clickable_item.gd")

var items = [
	{
		"NAME": "BUCKET",
		"TEXTURE": {
			"HITBOX": preload("res://art/item_art_overlays/cellar/bucket.png"),
			"HIDDEN": preload("res://art/item_art_overlays/cellar/bucket_GONE.png"),
		},
		"CAN_GRAB": true,
		"SPAWN": { "ROOM": "Cellar" },
		"INSPECT_TEXT": "Looks like there could be something valueable inside.",
		"INTERACTIONS": []
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
	}
]

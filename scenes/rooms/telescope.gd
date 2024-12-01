extends Node

var zodiacs = [
	{ "Name": "Aries", "Texture": load("res://art/room_art/specialroom_aries.png") },
	{ "Name": "Taurus", "Texture": load("res://art/room_art/specialroom_taurus.png") },
	{ "Name": "Gemini", "Texture": load("res://art/room_art/specialroom_gemini.png") },
	{ "Name": "Cancer", "Texture": load("res://art/room_art/specialroom_cancer.png") },
	{ "Name": "Leo", "Texture": load("res://art/room_art/specialroom_leo.png") },
	{ "Name": "Virgo", "Texture": load("res://art/room_art/specialroom_virgo.png") },
	{ "Name": "Libra", "Texture": load("res://art/room_art/specialroom_libra.png") },
	{ "Name": "Scorpius", "Texture": load("res://art/room_art/specialroom_scorpius.png") },
	{ "Name": "Sagittarius", "Texture": load("res://art/room_art/specialroom_sagittarius.png") },
	{ "Name": "Capricornus", "Texture": load("res://art/room_art/specialroom_capricornus.png") },
	{ "Name": "Aquarius", "Texture": load("res://art/room_art/specialroom_aquarius.png") },
	{ "Name": "Pisces", "Texture": load("res://art/room_art/specialroom_pisces.png") }
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_background()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_to_observatory_pressed() -> void:
	GameState.change_room("Observatory")

func _on_left_arrow_pressed() -> void:
	if get_meta("telescope_id") == 1:
		GameState.telescope_right -= 1
		if GameState.telescope_right < 0:
			GameState.telescope_right = zodiacs.size() - 1
	elif get_meta("telescope_id") == 2:
		GameState.telescope_left -= 1
		if GameState.telescope_left < 0:
			GameState.telescope_left = zodiacs.size() - 1

	update_background()

func _on_right_arrow_pressed() -> void:
	if get_meta("telescope_id") == 1:
		GameState.telescope_right += 1
		if GameState.telescope_right >= zodiacs.size():
			GameState.telescope_right = 0
	elif get_meta("telescope_id") == 2:
		GameState.telescope_left += 1
		if GameState.telescope_left >= zodiacs.size():
			GameState.telescope_left = 0
	
	update_background()

func update_background() -> void:
	if get_meta("telescope_id") == 1:
		$Background.texture = zodiacs[GameState.telescope_right]["Texture"]
		print(zodiacs[GameState.telescope_right]["Name"])
	elif get_meta("telescope_id") == 2:
		$Background.texture = zodiacs[GameState.telescope_left]["Texture"]
		print(zodiacs[GameState.telescope_left]["Name"])

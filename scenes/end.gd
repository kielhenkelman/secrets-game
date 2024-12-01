extends Node

const LAST_SCREEN = 5

var title_scene = load("res://scenes/title.tscn")

var screens = [
	load("res://art/room_art/specialroom_end_1.png"),
	load("res://art/room_art/specialroom_end_2.png"),
	load("res://art/room_art/specialroom_end_3.png"),
	load("res://art/room_art/specialroom_end_4.png"),
	load("res://art/room_art/specialroom_end_5.png")
]

var current_screen = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_continue_pressed() -> void:
	current_screen += 1
	$Background.texture = screens[current_screen - 1]
	
	if current_screen == LAST_SCREEN:
		$Continue.disabled = true
		$Continue.visible = false
		
		$FinalValue.text = "$" + Helpers.format_haul(GameState.current_value())
		$FinalValue.visible = true

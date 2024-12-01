extends Node

const LAST_SCREEN = 7

var main_scene = load("res://main.tscn")

var screens = [
	load("res://art/room_art/specialroom_title_1.png"),
	load("res://art/room_art/specialroom_title_2.png"),
	load("res://art/room_art/specialroom_title_3.png"),
	load("res://art/room_art/specialroom_title_4.png"),
	load("res://art/room_art/specialroom_title_5.png"),
	load("res://art/room_art/specialroom_title_6.png"),
	load("res://art/room_art/specialroom_title_7.png")
]

var current_screen = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_continue_pressed() -> void:
	if current_screen == LAST_SCREEN:
		var root = get_tree().get_root()
		root.get_node("Title").queue_free()
		root.add_child(main_scene.instantiate())
	else:
		current_screen += 1
		$Background.texture = screens[current_screen - 1]

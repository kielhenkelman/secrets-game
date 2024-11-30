extends Node

@export var pop_up_scene: PackedScene

var cursor_shape = load("res://art/idc_arrow.png")

var rooms = [
	"Gallery",
	"Studio",
	"Garage",
	"Cellar",
	"Kitchen",
	"BreakerPanel",
	"CakeRecipe",
	"Observatory",
	"Conservatory",
	"Office",
	"Bedroom",
	"Attic"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("room_changed", on_room_change)
	GameState.connect("popup_added", on_popup_added) 
	Input.set_custom_mouse_cursor(cursor_shape)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_room_change(room_name):
	for room in rooms:
		get_node(room).visible = false
	get_node(room_name).visible = true

func on_popup_added(text, duration):
	var pop_up = pop_up_scene.instantiate()
	pop_up.text_to_show = text
	pop_up.show_time = duration
	add_child(pop_up)

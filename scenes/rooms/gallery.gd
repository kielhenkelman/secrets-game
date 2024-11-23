extends BaseRoom

class_name Gallery

var items = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("flag_updated", on_flag_updated) 
	items = spawn_items("Gallery")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_flag_updated(flag: String, value: Variant):
	pass

func _on_to_studio_pressed() -> void:
	GameState.change_room("Studio")

func _on_to_garage_pressed() -> void:
	GameState.change_room("Garage")

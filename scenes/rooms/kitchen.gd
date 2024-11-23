extends BaseRoom

class_name Kitchen

var items = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("flag_updated", on_flag_updated) 
	items = spawn_items("Kitchen")
	print("kitchen._ready()")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_flag_updated(flag: String, value: Variant):
	pass

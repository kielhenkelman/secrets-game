extends BaseRoom

class_name Bedroom

var items = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("flag_updated", on_flag_updated) 
	items = spawn_items("Bedroom")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_flag_updated(flag: String, value: Variant):
	pass

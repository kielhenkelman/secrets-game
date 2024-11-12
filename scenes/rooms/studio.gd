extends BaseRoom

class_name Studio

var items = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("flag_updated", on_flag_updated) 
	items = spawn_items("Studio")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_flag_updated(flag: String, value: Variant):
	pass


func _on_to_gallery_pressed() -> void:
	GameState.change_room("Gallery")


func _on_to_kitchen_pressed() -> void:
	GameState.change_room("Kitchen")


func _on_to_cellar_pressed() -> void:
	GameState.change_room("Cellar")

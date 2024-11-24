extends BaseRoom

class_name Cellar

var items = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.connect("flag_updated", on_flag_updated) 
	items = spawn_items("Cellar")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_flag_updated(flag: String, value: Variant):
	if flag == 'VAULT_OPENED':
		items['VAULT'].set_texture(preload('res://art/items/vault_open.png'))
		items['VAULT'].clickable = false
		items['GEM'].visible = true
		items['GEM'].z_index = 2

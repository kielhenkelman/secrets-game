extends Control

var text_to_show: String = "Sample text"
var show_time: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect/Label.text = text_to_show
	$Timer.start(show_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()

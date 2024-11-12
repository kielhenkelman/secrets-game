extends Node2D

var light_on = preload("res://art/items/breaker_light_on.png")
var light_off = preload("res://art/items/breaker_light_off.png")

var switch_on = preload("res://art/items/breaker_switch_on.png")
var switch_off = preload("res://art/items/breaker_switch_off.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var switches = [false, false, false, false, false, false, false, false]

func flip(lights, indexes):
	for i in indexes:
		lights[i] = !lights[i]
	return lights
	
func apply_switches(switch_list):
	var lights = [false, false, false, false, false, false, false, false]
	if switch_list[0]:
		lights = flip(lights, [0, 2])
	if switch_list[1]:
		lights = flip(lights, [0, 1, 4, 7])
	if switch_list[2]:
		lights = flip(lights, [3, 4])
	if switch_list[3]:
		lights = flip(lights, [0, 1])
	if switch_list[4]:
		lights = flip(lights, [1, 3, 7])
	if switch_list[5]:
		lights = flip(lights, [1, 7])
	if switch_list[6]:
		lights = flip(lights, [2, 5, 6])
	if switch_list[7]:
		lights = flip(lights, [5, 6, 7])
	return lights

func update_lights(lights):
	$BreakerBackground/Light_0.texture = light_on if lights[0] else light_off
	$BreakerBackground/Light_1.texture = light_on if lights[1] else light_off
	$BreakerBackground/Light_2.texture = light_on if lights[2] else light_off
	$BreakerBackground/Light_3.texture = light_on if lights[3] else light_off
	$BreakerBackground/Light_4.texture = light_on if lights[4] else light_off
	$BreakerBackground/Light_5.texture = light_on if lights[5] else light_off
	$BreakerBackground/Light_6.texture = light_on if lights[6] else light_off
	$BreakerBackground/Light_7.texture = light_on if lights[7] else light_off
	
func update_breaker():
	var lights = apply_switches(switches)
	update_lights(lights)
	
	# If all lights are lit, trigger win
	for l in lights:
		if l == false:
			return
	GameState.popup("Lights are fixed")
	await get_tree().create_timer(3.0).timeout
	GameState.change_room("Garage")
	
	
	
func _on_to_garage_pressed() -> void:
	GameState.change_room("Garage")


func _on_switch_0_pressed() -> void:
	switches[0] = !switches[0]
	$BreakerBackground/Switch_0.texture_normal = switch_on if switches[0] else switch_off
	update_breaker()


func _on_switch_1_pressed() -> void:
	switches[1] = !switches[1]
	$BreakerBackground/Switch_1.texture_normal = switch_on if switches[1] else switch_off
	update_breaker()


func _on_switch_2_pressed() -> void:
	switches[2] = !switches[2]
	$BreakerBackground/Switch_2.texture_normal = switch_on if switches[2] else switch_off
	update_breaker()


func _on_switch_3_pressed() -> void:
	switches[3] = !switches[3]
	$BreakerBackground/Switch_3.texture_normal = switch_on if switches[3] else switch_off
	update_breaker()


func _on_switch_4_pressed() -> void:
	switches[4] = !switches[4]
	$BreakerBackground/Switch_4.texture_normal = switch_on if switches[4] else switch_off
	update_breaker()


func _on_switch_5_pressed() -> void:
	switches[5] = !switches[5]
	$BreakerBackground/Switch_5.texture_normal = switch_on if switches[5] else switch_off
	update_breaker()


func _on_switch_6_pressed() -> void:
	switches[6] = !switches[6]
	$BreakerBackground/Switch_6.texture_normal = switch_on if switches[6] else switch_off
	update_breaker()


func _on_switch_7_pressed() -> void:
	switches[7] = !switches[7]
	$BreakerBackground/Switch_7.texture_normal = switch_on if switches[7] else switch_off
	update_breaker()

extends Node

func format_haul(haul_value: int) -> String:
	var counter = 0
	var haul_str = str(haul_value)
	var result = ""
	for i in range(haul_str.length() - 1, -1, -1):
		if counter % 3 == 0 && counter != 0:
			result = "," + result
		result = haul_str[i] + result
		counter += 1
	return result

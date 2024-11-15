extends Node

var config_handler

func _ready():
	config_handler = preload("res://mods/KMod/Modules/ConfigHandler/config_handler.gd").new()
	add_child(config_handler)
	
	config_handler.load_config()
	var config_data = config_handler.config_data
	
	if config_data["SizeChanger"]:
		var size_changer = preload("res://mods/KMod/Modules/SizeChanger/size_changer.gd").new()
		add_child(size_changer)

	if config_data["KeybindFix"]:
		var keybind_fix = preload("res://mods/KMod/Modules/KeybindFix/keybind_fix.gd").new()
		add_child(keybind_fix)

	var k_recognizer = preload("res://mods/KMod/Modules/KRecognizer/k_recognizer.gd").new()
	add_child(k_recognizer)

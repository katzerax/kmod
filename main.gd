extends Node

var prefix = "[KMOD.main] "
var config_handler

func _ready():
	var k_recognizer = preload("res://mods/KMod/Scripts/KRecognizer/k_recognizer.gd").new()
	add_child(k_recognizer)
	
	config_handler = preload("res://mods/KMod/Scripts/ConfigHandler/config_handler.gd").new()
	add_child(config_handler)
	config_handler.load_config()
	var config_data = config_handler.config_data
	
	if config_data.has("SizeChanger") and config_data["SizeChanger"]:
		var size_changer = preload("res://mods/KMod/Scripts/SizeChanger/size_changer.gd").new()
		add_child(size_changer)

	if config_data.has("KeybindFix") and config_data["KeybindFix"]:
		var keybind_fix = preload("res://mods/KMod/Scripts/KeybindFix/keybind_fix.gd").new()
		add_child(keybind_fix)

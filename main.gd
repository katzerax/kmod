extends Node

var config_data = {
	"SizeChanger": true
}

func _get_config_location() -> String:
	var exe_path = OS.get_executable_path().get_base_dir()
	var config_path = exe_path.plus_file("GDWeave").plus_file("configs").plus_file("KMod.json")
	
	var dir = Directory.new()
	if dir.make_dir_recursive(config_path.get_base_dir()) != OK:
		print("Failed to create config directory:", config_path.get_base_dir())
	
	return config_path

func _save_config():
	var path = _get_config_location()
	var json_data = JSON.print(config_data)
	
	var file = File.new()
	if file.open(path, File.WRITE) == OK:
		file.store_string(json_data)
		file.close()
		print("Config saved successfully to:", path)
	else:
		print("Failed to open file for writing:", path)

func _load_config():
	var path = _get_config_location()
	var file = File.new()
	
	if not file.file_exists(path):
		print("Config file not found. Creating default config.")
		_save_config()
		return
	
	if file.open(path, File.READ) == OK:
		var data = file.get_as_text()
		file.close()
		
		var result = JSON.parse(data)
		if result.error == OK and typeof(result.result) == TYPE_DICTIONARY:
			config_data = result.result
			print("Config loaded successfully:", config_data)
		else:
			print("Failed to parse config file, using default values.")
	else:
		print("Failed to open file for reading:", path)

func _ready():
	_load_config()
	if config_data["SizeChanger"]:
		var size_changer = preload("res://mods/KMod/Modules/SizeChanger/main.gd").new()
		add_child(size_changer)

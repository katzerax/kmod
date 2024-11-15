extends Node

var prefix = "[KMOD.config_handler] "
var config_data = {}
var default_config_data = {
	"SizeChanger": true,
	"KeybindFix": true
}

func _get_gdweave_dir() -> String:
	var game_directory := OS.get_executable_path().get_base_dir()
	var folder_override: String
	var final_directory: String
	for argument in OS.get_cmdline_args():
		if argument.begins_with("--gdweave-folder-override="):
			folder_override = argument.trim_prefix("--gdweave-folder-override=").replace("\\", "/")
	if folder_override:
		var relative_path := game_directory.plus_file(folder_override)
		var is_relative := not ":" in relative_path and Directory.new().file_exists(relative_path)
		final_directory = relative_path if is_relative else folder_override
	else:
		final_directory = game_directory.plus_file("GDWeave")
	return final_directory

func _get_config_location() -> String:
	var gdweave_dir = _get_gdweave_dir()
	var config_path = gdweave_dir.plus_file("configs").plus_file("KMod.json")
	var dir = Directory.new()
	if dir.make_dir_recursive(config_path.get_base_dir()) != OK:
		print(prefix, "Failed to create config directory: ", config_path.get_base_dir())
	return config_path

func save_config():
	var path = _get_config_location()
	var formatted_json = "{\n"
	var keys = default_config_data.keys()
	for i in range(keys.size()):
		var key = keys[i]
		var value
		if config_data.has(key):
			value = config_data[key]
		else:
			value = default_config_data[key]
		if typeof(value) == TYPE_BOOL:
			value = str(value).to_lower()
		formatted_json += '    "' + key + '": ' + str(value)
		if i < keys.size() - 1:
			formatted_json += ','
		formatted_json += '\n'
	formatted_json += "}"
	var file = File.new()
	if file.open(path, File.WRITE) == OK:
		file.store_string(formatted_json)
		file.close()
		print(prefix, "Config saved successfully to: ", path)
	else:
		print(prefix, "Failed to open file for writing: ", path)

func load_config():
	var path = _get_config_location()
	var file = File.new()
	if not file.file_exists(path):
		print(prefix, "Config file not found. Creating default config.")
		config_data = default_config_data.duplicate()
		save_config()
		return
	if file.open(path, File.READ) == OK:
		var data = file.get_as_text()
		file.close()
		var result = JSON.parse(data)
		if result.error == OK and typeof(result.result) == TYPE_DICTIONARY:
			config_data = result.result
			print(prefix, "Config loaded successfully: ", config_data)
		else:
			print(prefix, "Failed to parse config file, using default values.")
			config_data = default_config_data.duplicate()
	else:
		print(prefix, "Failed to open file for reading: ", path)
	for key in default_config_data.keys():
		if not config_data.has(key):
			config_data[key] = default_config_data[key]
			print(prefix, "Default value for missing key: ", key, " set to ", default_config_data[key])
	save_config()

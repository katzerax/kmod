extends Node

var dependency_prefix = "[KMOD.dependency_check] "

func _get_gdweave_dir() -> String:
	var game_directory = OS.get_executable_path().get_base_dir()
	var folder_override = _get_folder_override()
	if folder_override:
		var relative_path = game_directory.plus_file(folder_override)
		var is_relative = not ":" in relative_path and Directory.new().file_exists(relative_path)
		return relative_path if is_relative else folder_override
	else:
		return game_directory.plus_file("GDWeave")

func _get_folder_override() -> String:
	for argument in OS.get_cmdline_args():
		if argument.begins_with("--gdweave-folder-override="):
			return argument.trim_prefix("--gdweave-folder-override=").replace("\\", "/")
	return ""

func _check_manifest(manifest_path: String, api_name: String) -> bool:
	var file = File.new()
	if file.file_exists(manifest_path):
		print(dependency_prefix, api_name, "manifest found!")
		return true
	else:
		print(dependency_prefix, api_name, "manifest not found.")
		return false

func _check_for_size_unlocker() -> bool:
	var gdweave_dir = _get_gdweave_dir()
	var manifest_path = ""
	if gdweave_dir != "":
		if _get_folder_override() != "":
			manifest_path = gdweave_dir.plus_file("mods").plus_file("nowaha-SizeUnlocker").plus_file("manifest.json")
		else:
			manifest_path = gdweave_dir.plus_file("mods").plus_file("SizeUnlocker").plus_file("manifest.json")
		return _check_manifest(manifest_path, "SizeUnlocker ")
	return false

func _check_for_title_api() -> bool:
	var gdweave_dir = _get_gdweave_dir()
	var manifest_path = ""
	if gdweave_dir != "":
		if _get_folder_override() != "":
			manifest_path = gdweave_dir.plus_file("mods").plus_file("LoafWF-TitleAPI").plus_file("manifest.json")
		else:
			manifest_path = gdweave_dir.plus_file("mods").plus_file("TitleAPI").plus_file("manifest.json")
		return _check_manifest(manifest_path, "TitleAPI ")
	return false

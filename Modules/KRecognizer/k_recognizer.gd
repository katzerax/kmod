extends Node

var prefix = "[KMOD.k_recognizer] "
var title_api

func _register_kmod_titles():
	title_api.register_title(76561198233616048, "[color=#ff1a5c]KMod Dev[/color]", false)
	title_api.register_title(76561198799078563, "[color=#f6a4f3]Paw tuah[/color]", false)

func _ready():
	if _check_r2_titleapi_location() or _check_for_title_api():
		yield(wait_for_title_api(), "completed")
		if title_api != null:
			_register_kmod_titles()

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

func _check_r2_titleapi_location() -> bool:
	var gdweave_dir = _get_gdweave_dir()
	var manifest_path = gdweave_dir.plus_file("mods").plus_file("LoafWF-TitleAPI").plus_file("manifest.json")
	return _check_manifest(manifest_path, "r2modman TitleAPI ")

func _check_for_title_api() -> bool:
	var gdweave_dir = _get_gdweave_dir()
	var manifest_path = gdweave_dir.plus_file("mods").plus_file("TitleAPI").plus_file("manifest.json")
	return _check_manifest(manifest_path, "TitleAPI ")

func _check_manifest(manifest_path: String, api_name: String) -> bool:
	var file = File.new()
	if file.file_exists(manifest_path):
		print(prefix, api_name, "manifest found!")
		return true
	else:
		print(prefix, api_name, "manifest not found.")
		return false

func wait_for_title_api() -> GDScriptFunctionState:
	print(prefix, "Waiting for TitleAPI to be loaded...")
	while get_node_or_null("/root/TitleAPI") == null:
		yield(get_tree(), "idle_frame")
	title_api = get_node("/root/TitleAPI")
	if title_api != null:
		print(prefix, "TitleAPI node found and loaded successfully.")
	else:
		print(prefix, "TitleAPI node not found after waiting.")
	return null

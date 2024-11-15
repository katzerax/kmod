extends Node

var prefix = "[KMOD.k_recognizer] "
var title_api

func _ready():
	if _check_for_title_api():
		yield(wait_for_title_api(), "completed")
		if title_api != null:
			title_api.register_title(76561198233616048, "[color=#ff1a5c]KMod Dev[/color]", false)
			title_api.register_title(76561198799078563, "[color=#f6a4f3]Paw tuah[/color]", false)

func _check_for_title_api() -> bool:
	var exe_path = OS.get_executable_path().get_base_dir()
	var manifest_path = exe_path.plus_file("GDWeave").plus_file("mods").plus_file("TitleAPI").plus_file("manifest.json")
	print(prefix, "Checking for TitleAPI manifest")
	var file = File.new()
	if file.file_exists(manifest_path):
		print(prefix, "TitleAPI manifest found!")
		return true
	else:
		print(prefix, "TitleAPI manifest not found.")
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

extends Node

var prefix = "[KMOD.k_recognizer] "
var title_api
var dependency_check_script : Node = null
var config_handler
var override_dependencies = false

func _ready():
	config_handler = preload("res://mods/KMod/Scripts/ConfigHandler/config_handler.gd").new()
	add_child(config_handler)
	config_handler.load_config()
	var config_data = config_handler.config_data
	override_dependencies = config_data.has("OverrideDependencyChecks") and config_data["OverrideDependencyChecks"]
	dependency_check_script = preload("res://mods/KMod/Scripts/DependencyChecks/dependency_checks.gd").new()
	add_child(dependency_check_script)
	if override_dependencies or dependency_check_script._check_for_title_api():
		print(prefix, "TitleAPI dependency check passed.")
		yield(wait_for_title_api(), "completed")
		if title_api != null:
			_register_kmod_titles()
	else:
		print(prefix, "TitleAPI dependency check failed. Titles will not be registered.")
	config_handler.queue_free()
	dependency_check_script.queue_free()

func _register_kmod_titles():
	if title_api != null:
		title_api.register_title(76561198233616048, "[color=#ff1a5c]KMod Dev[/color]", false)
		title_api.register_title(76561198799078563, "[color=#f6a4f3]Paw tuah[/color]", false)
		print(prefix, "KMod titles registered successfully.")
	else:
		print(prefix, "Failed to register titles: TitleAPI is null.")

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

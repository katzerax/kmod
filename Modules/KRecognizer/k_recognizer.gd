extends Node

var prefix = "[KMOD.k_recognizer] "
var title_api
var dependency_check_script : Node = null

func _register_kmod_titles():
	title_api.register_title(76561198233616048, "[color=#ff1a5c]KMod Dev[/color]", false)
	title_api.register_title(76561198799078563, "[color=#f6a4f3]Paw tuah[/color]", false)

func _ready():
	var dependency_check_script = preload("res://mods/KMod/Modules/DependencyChecks/dependency_checks.gd").new()
	var has_title = dependency_check_script._check_for_title_api()
	if has_title:
		yield(wait_for_title_api(), "completed")
		if title_api != null:
			_register_kmod_titles()
	dependency_check_script.queue_free()

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

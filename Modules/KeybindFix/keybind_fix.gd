extends Node

var prefix = "[KMOD.keybind_fix] "
var previous_scene_name = ""
var has_executed_menu_action = false

func _ready():
	print(prefix, "Initialization complete. Starting scene check.")
	set_process(true)

func _process(delta):
	if has_executed_menu_action:
		set_process(false)
		return
	var current_scene = get_tree().current_scene
	var current_scene_name = ""
	if current_scene != null:
		current_scene_name = current_scene.name
	else:
		current_scene_name = "null"
	if current_scene_name != previous_scene_name:
		print(prefix, "Scene changed to: ", current_scene_name)
		previous_scene_name = current_scene_name
		if current_scene_name != "splash" and current_scene_name != "null":
			_open_and_close_options_menu()
			has_executed_menu_action = true

func _open_and_close_options_menu():
	if typeof(OptionsMenu) == TYPE_OBJECT and OptionsMenu.has_method("_open") and OptionsMenu.has_method("_close"):
		OptionsMenu._open()
		OptionsMenu._close()
		print(prefix, "Executed OptionsMenu _open & _close functions.")
	else:
		print(prefix, "OptionsMenu not found or does not have required methods.")

extends Node
var prefix = "[KMOD.keybind_fix] "

func _ready():
	get_tree().connect("scene_changed", self, "_on_scene_changed")
	print(prefix, "Connected to scene_changed signal.")

func _on_scene_changed():
	var current_scene_name = get_tree().current_scene.name

func yield_until_not_splash():
	while get_tree().current_scene.name == "splash":
		yield(get_tree(), "idle_frame")
	print(prefix, "Scene is no longer splash")
	_open_and_close_options_menu()

func _open_and_close_options_menu():
	OptionsMenu._open()
	OptionsMenu._close()
	print(prefix, "Executed OptionsMenu _open & _close functions.")

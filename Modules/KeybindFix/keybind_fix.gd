extends Node

var main_menu_loaded = false
var check_timer

func _ready():
	check_timer = Timer.new()
	check_timer.wait_time = 1
	check_timer.one_shot = false
	check_timer.connect("timeout", self, "_check_for_main_menu")
	add_child(check_timer)
	check_timer.start()

func _check_for_main_menu():
	var current_scene_name = get_tree().current_scene.name

	if current_scene_name == "main_menu" and !main_menu_loaded:
		main_menu_loaded = true
		_open_and_close_options_menu()
		check_timer.stop()

func _open_and_close_options_menu():
	OptionsMenu._open()
	OptionsMenu._close()

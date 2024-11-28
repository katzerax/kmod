extends Node

var prefix = "[KMOD.size_changer] "
const shrink = KEY_COMMA
const grow = KEY_PERIOD
const reset = KEY_SLASH
const SAVE_FILE_PATH = "user://KMod.save"
const IDLE_SAVE_DELAY = 6.0
var player
var last_scene_name = ""
var player_size = 1.0
var save_timer = null
var size_min = 0.6
var size_max = 1.4
var dependency_check_script : Node = null

var override_dependencies = false

func _ready():
	var config_handler = preload("res://mods/KMod/Scripts/ConfigHandler/config_handler.gd").new()
	config_handler.load_config()
	var config_data = config_handler.config_data
	override_dependencies = config_data.has("OverrideDependencyChecks") and config_data["OverrideDependencyChecks"]
	if override_dependencies:
		print(prefix, "OverrideDependencyChecks enabled. Assuming all dependencies are present.")
	dependency_check_script = preload("res://mods/KMod/Scripts/DependencyChecks/dependency_checks.gd").new()
	_apply_size_unlocker()
	config_handler.queue_free()
	dependency_check_script.queue_free()
	initialize()

func initialize():
	if !in_lobby():
		print(prefix, "In main menu or loading menu. SizeChanger will not initialize.")
		return
	player = get_player_node()
	last_scene_name = get_tree().current_scene.name
	if player:
		load_player_size()
		print(prefix, "SizeChanger initialized with player instance: ", player.name)
	else:
		print(prefix, "No player instance found yet. Waiting...")

func _apply_size_unlocker():
	if override_dependencies:
		print(prefix, "Dependencies overridden. Using extended size limits.")
		size_min = 0.1
		size_max = 10.0
		return
	var has_unlocker = dependency_check_script._check_for_size_unlocker()
	if has_unlocker:
		print(prefix, "SizeUnlocker detected: Using extended size limits.")
		size_min = 0.1
		size_max = 10.0
	else:
		print(prefix, "SizeUnlocker not detected: Using default size limits.")
		size_min = 0.6
		size_max = 1.4

func get_player_node():
	return get_tree().current_scene.get_node_or_null("Viewport/main/entities/player")

func in_lobby() -> bool:
	var current_scene_name = get_tree().current_scene.name
	return current_scene_name != "main_menu" and current_scene_name != "loading_menu" and current_scene_name != "splash"

func is_chatbox_active() -> bool:
	var playerhud = get_tree().get_root().get_node_or_null("playerhud")
	return playerhud and playerhud.using_chat

func _process(delta):
	var current_scene_name = get_tree().current_scene.name
	if current_scene_name != last_scene_name:
		last_scene_name = current_scene_name
		player = null
	if !player:
		player = get_player_node()
		if player:
			print(prefix, "Player instance found: ", player.name)
			load_player_size()
		else:
			return
	if not is_instance_valid(player) or is_chatbox_active():
		return
	var size_changed = false
	if Input.is_key_pressed(grow):
		player.player_scale = clamp(player.player_scale + 0.4 * delta, size_min, size_max)
		size_changed = true
	elif Input.is_key_pressed(shrink):
		player.player_scale = clamp(player.player_scale - 0.4 * delta, size_min, size_max)
		size_changed = true
	elif Input.is_key_pressed(reset):
		player.player_scale = 1.0
		size_changed = true
	if size_changed:
		player_size = player.player_scale
		start_save_timer()

func start_save_timer():
	if save_timer:
		save_timer.stop()
		save_timer.queue_free()
	save_timer = Timer.new()
	save_timer.wait_time = IDLE_SAVE_DELAY
	save_timer.one_shot = true
	save_timer.connect("timeout", self, "_on_save_timer_timeout")
	add_child(save_timer)
	save_timer.start()

func _on_save_timer_timeout():
	print(prefix, "Save timer completed, saving player size.")
	save_player_size()
	save_timer.queue_free()
	save_timer = null

func save_player_size():
	var save_file = File.new()
	if save_file.open(SAVE_FILE_PATH, File.WRITE) == OK:
		var save_data = { "player_size": player_size }
		save_file.store_var(save_data)
		save_file.close()
		print(prefix, "Player size saved to file:", player_size)
	else:
		print(prefix, "Error saving player size.")

func load_player_size():
	var load_file = File.new()
	if load_file.file_exists(SAVE_FILE_PATH):
		if load_file.open(SAVE_FILE_PATH, File.READ) == OK:
			var save_data = load_file.get_var()
			load_file.close()
			if "player_size" in save_data:
				player_size = save_data["player_size"]
				if is_instance_valid(player):
					player.player_scale = player_size
			else:
				save_player_size()
	else:
		save_player_size()

func _notification(what):
	if what == NOTIFICATION_ENTER_TREE:
		var current_scene = get_tree().current_scene
		if current_scene.name != last_scene_name:
			last_scene_name = current_scene.name
			player = null
			print(prefix, "Scene changed to: ", current_scene.name)

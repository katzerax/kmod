extends Node

const shrink = KEY_COMMA
const grow = KEY_PERIOD
const reset = KEY_SLASH
const SAVE_FILE_PATH = "user://KMod.save"
const IDLE_SAVE_DELAY = 6.0

var player
var last_scene_name = ""
var player_size = 1.0
var save_timer = null

func _ready():
	initialize()

func initialize():
	if !in_lobby():
		print("In main menu or loading menu. SizeChanger will not initialize.")
		return
	player = get_player_node()
	last_scene_name = get_tree().current_scene.name
	if player:
		load_player_size()
		print("SizeChanger initialized with player instance: ", player.name)
	else:
		print("No player instance found yet. Waiting...")

func get_player_node():
	return get_tree().current_scene.get_node_or_null("Viewport/main/entities/player")

func in_lobby():
	var current_scene_name = get_tree().current_scene.name
	return current_scene_name != "main_menu" and current_scene_name != "loading_menu" and current_scene_name != "splash"

func is_chatbox_active():
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
			print("Player instance found: ", player.name)
			load_player_size()
		else:
			return

	if not is_instance_valid(player) or is_chatbox_active():
		return

	var size_changed = false

	if Input.is_key_pressed(grow):
		player.player_scale = clamp(player.player_scale + 0.4 * delta, 0.6, 1.4)
		size_changed = true
	elif Input.is_key_pressed(shrink):
		player.player_scale = clamp(player.player_scale - 0.4 * delta, 0.6, 1.4)
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
	print("Save timer started for ", IDLE_SAVE_DELAY, " seconds.")

func _on_save_timer_timeout():
	print("Save timer completed, saving player size.")
	save_player_size()
	save_timer.queue_free()
	save_timer = null

func save_player_size():
	var save_file = File.new()
	if save_file.open(SAVE_FILE_PATH, File.WRITE) == OK:
		var save_data = { "player_size": player_size }
		save_file.store_var(save_data)
		save_file.close()
		print("Player size saved to file:", player_size)
	else:
		print("Error saving player size.")

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

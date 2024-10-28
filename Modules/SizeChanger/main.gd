extends Node

const shrink = KEY_COMMA
const grow = KEY_PERIOD
const reset = KEY_SLASH

var player

func _ready():
	initialize()

func initialize():
	if !in_lobby():
		print("In main menu or loading menu. SizeChanger will not initialize.")
		return

	player = get_player_node()
	if player:
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
	if not player:
		player = get_player_node()
		if player:
			print("Player instance found: ", player.name)
		else:
			print("Still waiting for player instance...")
			return

	if not is_instance_valid(player) or is_chatbox_active():
		return

	if Input.is_key_pressed(grow):
		player.player_scale = clamp(player.player_scale + 0.4 * delta, 0.1, 100)
		print("New scale: ", player.player_scale)

	elif Input.is_key_pressed(shrink):
		player.player_scale = clamp(player.player_scale - 0.4 * delta, 0.1, 100)
		print("New scale: ", player.player_scale)

	elif Input.is_key_pressed(reset):
		player.player_scale = 1.0
		print("New scale: ", player.player_scale)

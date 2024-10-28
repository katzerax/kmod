extends Node

var size_changer

func _ready():
	size_changer = preload("res://mods/KMod/Modules/SizeChanger/main.gd").new()
	add_child(size_changer)

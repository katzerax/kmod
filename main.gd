extends Node

# Preload the modules for easier access
var size_changer

func _ready():
	
	# Initialize SizeChanger
	size_changer = preload("res://mods/KMod/Modules/SizeChanger/main.gd").new()
	add_child(size_changer)  # Add SizeChanger as a child to the current node

extends Node2D

@onready var templates = get_node("/root/RoomTemplates")

func _ready():
	var room = get_node(get_path())
	templates.rooms.append(room)

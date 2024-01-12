extends Node

class_name Rooms

@export var bottom_rooms = []
@export var left_rooms = []
@export var top_rooms = []
@export var right_rooms = [] 

func _get(property):
	match property:
		"bottom_rooms":
			return bottom_rooms
		"left_rooms":
			return left_rooms
		"top_rooms":
			return top_rooms
		"right_rooms":
			return right_rooms
		_:
			return null

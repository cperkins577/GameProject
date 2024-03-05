extends Node

class_name Rooms

@export var bottom_rooms = []
@export var left_rooms = []
@export var top_rooms = []
@export var right_rooms = [] 

var rooms = []
@export var wait_time: float
var spawned_boss: bool
@export var boss_scene: PackedScene


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

func _physics_process(delta):
	if wait_time <= 0 and spawned_boss == false:
		for i in range(rooms.size()):
			if i == rooms.size()-1:
				var boss = boss_scene.instantiate()
				get_node("../World").add_child(boss)
				boss.position = rooms[i].global_position
				spawned_boss = true
	else:
		wait_time -= delta

extends Node2D

class_name Room_Spawner

@onready var templates = get_node("/root/RoomTemplates")

@export var opening_direction = 0
# 1 --> Need bottom door
# 2 --> Need left door
# 3 --> Need top door
# 4 --> Need right door
@export var spawn_max = 2
var spawned
var spawned_total = 0

func _ready():
	spawned = false
	spawn()

func is_spawned():
	return spawned

func spawn():
		match opening_direction:
			1:
				var bottom_rooms = templates.get("bottom_rooms")
				var rng = randi_range(0,bottom_rooms.size()-1)
				var scene = bottom_rooms[rng]
				var instance = scene.instantiate()
				instance.position = position
				get_parent().add_sibling.call_deferred(instance)
			2:
				var right_rooms = templates.get("right_rooms")
				var rng = randi_range(0,right_rooms.size()-1)
				var scene = right_rooms[rng]
				var instance = scene.instantiate()
				instance.position = position
				get_parent().add_sibling.call_deferred(instance)
			3:
				var top_rooms = templates.get("top_rooms")
				var rng = randi_range(0,top_rooms.size()-1)
				var scene = top_rooms[rng]
				var instance = scene.instantiate()
				instance.position = position
				get_parent().add_sibling.call_deferred(instance)
			4:
				var left_rooms = templates.get("left_rooms")
				var rng = randi_range(0,left_rooms.size()-1)
				var scene = left_rooms[rng]
				var instance = scene.instantiate()
				instance.position = position
				get_parent().add_sibling.call_deferred(instance)
			_:
				pass
		spawned = true
		spawned_total += 1


func _on_area_2d_area_entered(area):
	print("deleting")
	if area is Room_Spawner:
		queue_free()

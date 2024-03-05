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
	

func check_overlap():
	var areas = $Area2D.get_overlapping_areas()
	for area in areas:
		if area.get_parent().has_method("spawn"):
			return true

#func _on_area_2d_area_entered(area):
	##print("deleting")
	#if area.get_parent().has_method("spawn") and area.get_parent().is_spawned() == true:
		##print("deleted")
		#queue_free()

func spawn():
	await get_tree().physics_frame
	if check_overlap() == true:
		spawned = true
		opening_direction = 0
		free()
	match opening_direction:
		1:
			print("Spawning up")
			var bottom_rooms = templates.get("bottom_rooms")
			var rng = randi_range(0,bottom_rooms.size()-1)
			var scene = bottom_rooms[rng]
			var instance = scene.instantiate()
			get_parent().add_sibling.call_deferred(instance)
			instance.position = global_position
		2:
			print("Spawning right")
			var left_rooms = templates.get("left_rooms")
			var rng = randi_range(0,left_rooms.size()-1)	
			var scene = left_rooms[rng]
			var instance = scene.instantiate()
			get_parent().add_sibling.call_deferred(instance)
			instance.position = global_position
		3:
			print("Spawning down")
			var top_rooms = templates.get("top_rooms")
			var rng = randi_range(0,top_rooms.size()-1)
			var scene = top_rooms[rng]
			var instance = scene.instantiate()
			get_parent().add_sibling.call_deferred(instance)
			instance.position = global_position
		4:
			print("spawning left")
			var right_rooms = templates.get("right_rooms")
			var rng = randi_range(0,right_rooms.size()-1)
			var scene = right_rooms[rng]
			var instance = scene.instantiate()
			get_parent().add_sibling.call_deferred(instance)
			instance.position = global_position
		_:
			pass
	spawned = true
extends Node2D

@onready var templates = get_node("/root/RoomTemplates")

@export var room_difficulty = 10
@export var allow_enemies = true
var current_cr = 0
#Room size in px
const ROOM_SIZE = 80
var rng = RandomNumberGenerator.new()

var enemy_scene = preload("res://scenes/enemy.tscn")

func _ready():
	var room = get_node(get_path())
	templates.rooms.append(room)
	if allow_enemies:
		spawn_enemies()

func spawn_enemies():
	print("Spawning enemy")
	var max_cr = room_difficulty + rng.randi_range(-6,6)
	while current_cr <= max_cr:
		var enemy = enemy_scene.instantiate()
		get_parent().add_child.call_deferred(enemy)
		enemy.global_position = global_position
		enemy.position.y += rng.randi_range(-ROOM_SIZE,ROOM_SIZE)
		enemy.position.x += rng.randi_range(-ROOM_SIZE, ROOM_SIZE)
		current_cr += enemy.ENEMY_CR

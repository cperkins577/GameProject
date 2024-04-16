extends CharacterBody2D

@export var speed = 40
var player_chase = false
var player = null

const ENEMY_CR = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_chase:
		velocity = (player.get_global_position() - position).normalized() * speed * delta
	
	else:
		velocity = lerp(velocity,Vector2.ZERO,0.03)
	move_and_collide(velocity)

func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body is Player:
		player = null
		player_chase = false

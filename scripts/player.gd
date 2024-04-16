class_name Player extends CharacterBody2D
@export var speed = 100
var screen_size
var current_dir

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	current_dir = "down"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Scripts to set movement vectors when key is pressed
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		current_dir = "up"
		play_anim("move",current_dir)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		current_dir = "down"
		play_anim("move",current_dir)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		current_dir = "left"
		play_anim("move",current_dir)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		current_dir = "right"
		play_anim("move",current_dir)
	if velocity.x==0 and velocity.y==0:
		play_anim("idle",current_dir)
	
	# Normalizes the vectors to maintain constant speed in all directions
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
	
func play_anim(type, dir):
	var anim = $AnimatedSprite2D
	if type == "move":
		match dir:
			"up":
				anim.play("up_walk")
			"down":
				anim.play("down_walk")
			"left":
				anim.play("left_walk")
			"right":
				anim.play("right_walk")
			_:
				anim.play("down_walk")
	if type == "idle":
		match dir:
			"up":
				anim.play("up_idle")
			"down":
				anim.play("down_idle")
			"left":
				anim.play("left_idle")
			"right":
				anim.play("right_idle")
			_:
				anim.play("down_idle")

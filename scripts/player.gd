extends CharacterBody2D
@export var speed = 200
@onready var animation_tree : AnimationTree = $AnimationTree
var screen_size
var current_dir

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	current_dir = "down"
	animation_tree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Scripts to set movement vectors when key is pressed
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if velocity.x==0 and velocity.y==0:
		pass
	# Normalizes the vectors to maintain constant speed in all directions
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	update_anim_para()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()

func update_anim_para():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree.set("parameters/idle/blend_position", velocity)
		animation_tree.set("parameters/walk/blend_position", velocity)
		animation_tree.set("parameters/attack/blend_position", velocity)
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true
	
	if Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/attack"] = true
	else:
		animation_tree["parameters/conditions/attack"] = false

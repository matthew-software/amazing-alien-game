extends CharacterBody2D


const SPEED = 150.0
const SLOW_SPEED = 50.0

var alive = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")
@onready var jump_sound = $JumpSound
@onready var jump_second_sound = $JumpSecondSound
@onready var jump_super_sound = $JumpSuperSound

var directionx
var directiony
var jumps = 2
var extra_jump = false
var super_jump = false
var falling = false
var slow = false


func _physics_process(delta):

	# Check if going slow (pressing shift)
	if Input.is_action_pressed("slow"):
		slow = true
	else:
		slow = false
	# Get the input direction and handle the movement/deceleration.
	directionx = Input.get_axis("ui_left", "ui_right")
	directiony = Input.get_axis("ui_up", "ui_down")
	
	# Flip direction if Player turns around
	if directionx == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif directionx == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	# Handle flying (with sideways movement involved).
	if directionx:
		if slow:
			velocity.x = directionx * SLOW_SPEED
			velocity.y = directiony * SLOW_SPEED
			anim.play("Fly")
		else:
			velocity.x = directionx * SPEED
			velocity.y = directiony * SPEED
			anim.play("Soar")
	# Handle flying directly up or down.
	elif directiony:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		get_node("AnimatedSprite2D").flip_h = false
		if slow:
			velocity.y = directiony * SLOW_SPEED
			if directiony < 0:
				anim.play("FlyUp")
			else:
				anim.play("FlyDown")
		else:
			velocity.y = directiony * SPEED
			if directiony < 0:
				anim.play("SoarUp")
			else:
				anim.play("SoarDown")
	# Handle stopping.
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		anim.play("Idle")

	move_and_slide()
	
	if alive == false:
		Game.lives -= 1
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")

extends CharacterBody2D


const SPEED = 100.0
const SLOW_SPEED = 50.0
const JUMP_VELOCITY = -300
const JUMP_VELOCITY_2 = -200.0
const JUMP_VELOCITY_3 = -600.0 # super-jump

var alive = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")
@onready var jump_sound = $JumpSound
@onready var jump_second_sound = $JumpSecondSound
@onready var jump_super_sound = $JumpSuperSound

var direction
var jumps = 2
var extra_jump = false
var super_jump = false
var falling = false
var slow = false

# AI variables
var ai_jump = false
var ai_slow = false
var ai_left = 0
var ai_right = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping.
	if ai_jump:
		if jumps == 2:
			velocity.y = JUMP_VELOCITY
			anim.play("Jump")
			jump_sound.play()
			jumps -= 1
		elif jumps == 1:
			velocity.y = JUMP_VELOCITY_2
			anim.play("Jump")
			jump_second_sound.play()
			jumps -= 1
	
	if super_jump == true:
		velocity.y = JUMP_VELOCITY_3
		anim.play("Jump")
		jump_super_sound.play()
		super_jump = false
		jumps = 0
	elif extra_jump == true:
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		jump_sound.play()
		extra_jump = false
		jumps = 0

	# Check if going fast (pressing shift)
	if ai_slow:
		slow = true
	else:
		slow = false
	# Get the input direction and handle the movement/deceleration.
	direction = ai_right - ai_left
	
	# Flip direction if Player turns around
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	# Handle running.
	if direction:
		if slow:
			velocity.x = direction * SLOW_SPEED
			if velocity.y == 0:
				anim.play("Sneak")
		else:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("Run")
	# Handle stopping.
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	
	# Handle falling.
	if velocity.y > 0 and falling == false:
		anim.play("Fall")
		falling = true
	elif velocity.y == 0:
		jumps = 2
		falling = false

	move_and_slide()
	
	if alive == false:
		queue_free()

func artificial_intelligence():
	pass

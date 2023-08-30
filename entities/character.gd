extends CharacterBody2D
class_name Character


var speed = 100.0
var slow_speed = 50.0
var jump_velocity = -300
var jump_velocity_2 = -200.0
var jump_velocity_3 = -600.0 # super-jump

var alive = true
var pause = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")
@onready var camera = $Camera2D
@onready var death_timer = $DeathTimer

@onready var jump_sound = $JumpSound
@onready var jump_second_sound = $JumpSecondSound
@onready var jump_super_sound = $JumpSuperSound
@onready var hurt_sound = $HurtSound
@onready var plunge_sound = $PlungeSound


var direction = self.position.normalized()
var jumps = 2
var extra_jump = false
var super_jump = false
var falling = false
var slow = false

var move_jump = false
var move_horizontal = 0.0
var move_vertical = 0.0
var move_slow = false


func _physics_process(delta):
	if pause == true:
		anim.stop(false)
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Check if going slow (pressing shift)
		if move_slow:
			slow = true
		else:
			slow = false
		# Get the input direction and handle the movement/deceleration.
		direction.x = move_horizontal
		direction.y = move_vertical
		
		# Flip direction if Player turns around
		if direction.x == -1:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction.x == 1:
			get_node("AnimatedSprite2D").flip_h = false
			
		move()
		move_and_slide()
		
	check_death()


func move():
	jump()
	run()
	fall()

# Handle jumping
func jump():
	# First and second normal jumps
	if move_jump:
		if jumps == 2:
			velocity.y = jump_velocity
			anim.play("Jump")
			jump_sound.play()
			jumps -= 1
		elif jumps == 1:
			velocity.y = jump_velocity_2
			anim.play("Jump")
			jump_second_sound.play()
			jumps -= 1
	
	# Super jump
	if super_jump == true:
		velocity.y = jump_velocity_3
		anim.play("Jump")
		jump_super_sound.play()
		super_jump = false
		jumps = 0
	# Extra jump
	elif extra_jump == true:
		velocity.y = jump_velocity
		anim.play("Jump")
		jump_sound.play()
		extra_jump = false
		jumps = 0
	

func run():
	# Run
	if direction.x:
		if slow:
			velocity.x = direction.x * slow_speed
			if velocity.y == 0:
				anim.play("Sneak")
		else:
			velocity.x = direction.x * speed
			if velocity.y == 0:
				anim.play("Run")
	# Stop
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if velocity.y == 0:
			anim.play("Idle")
	

func fall():
	# Fall
	if velocity.y > 0 and falling == false:
		anim.play("Fall")
		falling = true
	elif velocity.y == 0:
		jumps = 2
		falling = false


func check_death():
	if alive == false:
		queue_free()
		Utils.saveGame()
		get_tree().change_scene_to_file("res://main.tscn")


func _on_death_timer_timeout():
	alive = false

extends CharacterBody2D

const SPEED = 60

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimatedSprite2D")
@onready var death_sound = $DeathSound

var direction = 1


func _ready():
	anim.play("Run")
	get_node("AnimatedSprite2D").flip_h = true
	direction = -1


func _physics_process(delta):
	if anim.animation != "Death":
		velocity.y += gravity * delta
		
		# Flip direction if Rat hits wall
		if is_on_wall():
			if get_node("AnimatedSprite2D").flip_h == false:
				get_node("AnimatedSprite2D").flip_h = true
				direction = -1
			else:
				get_node("AnimatedSprite2D").flip_h = false
				direction = 1
		
		# Handle running.
		velocity.x = direction * SPEED
		anim.play("Run")
		
		move_and_slide()


func death():
	$CollisionShape2D.set_deferred("disabled", true)
	anim.play("Death")
	death_sound.play()
	await anim.animation_finished
	self.queue_free()


func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			death()
			body.extra_jump = true


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			body.alive = false

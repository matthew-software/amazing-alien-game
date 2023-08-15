extends CharacterBody2D

const SPEED = 30

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var flee = false
var flying = false
var flight_time = 3 # seconds

@onready var anim = get_node("AnimatedSprite2D")
@onready var death_sound = $DeathSound

var direction = self.position.normalized()

var temp = 0


func _ready():
	player = get_node("../../Player/Player")
	face_player()
	anim.play("Idle")


func _physics_process(delta):
	if anim.animation != "Death":
		if flying == false:
			velocity.y += gravity * delta
			if flee == true:
				# If wall is hit upon fleeing, stop and fly up in the air
				if is_on_wall():
					direction.y = -1
					velocity.y = direction.y * SPEED
					velocity.x = 0
					face_player()
					anim.play("Fly")
					flying = true
					flee = false
				# If wall is not hit yet upon fleeing, keep fleeing
				else:
					direction = (self.position - player.position).normalized()
					if direction.x > 0:
						anim.flip_h = false
					else:
						anim.flip_h = true
					# If player is looking away, sneak up on him...
					if anim.flip_h != get_node("../../Player/Player/AnimatedSprite2D").flip_h:
						direction = (player.position - self.position).normalized()
						if direction.x > 0:
							anim.flip_h = false
						else:
							anim.flip_h = true
					velocity.x = direction.x * SPEED
					anim.play("Run")
			else:
				velocity.x = 0
				anim.play("Idle")
		else: # flying == true
			if flight_time > 0:
				flight_time -= delta
				# Once "flight_time" has been completed, suspend flight in midair indefinitely
				if flight_time <= 0:
					flight_time = 0
					velocity.y = 0
		
		move_and_slide()


func face_player():
	direction = (player.position - self.position).normalized()
	if direction.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true


func death():
	$CollisionShape2D.set_deferred("disabled", true)
	anim.play("Death")
	death_sound.play()
	await anim.animation_finished
	self.queue_free()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		if flying == false:
			flee = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		flee = false
		face_player()


func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			death()
			body.super_jump = true


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			body.alive = false

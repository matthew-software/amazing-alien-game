extends CharacterBody2D
class_name Enemy

@export var speed: int = 30
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var super_player

@onready var anim = get_node("AnimatedSprite2D")
@onready var collision_shape = $CollisionShape2D
@onready var death_sound = $DeathSound
@onready var cry_sound = $CrySound

var direction = self.position.normalized()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_tree().root.get_node("Main").get_node_or_null("Level1"):
		player = get_tree().root.get_node("Main").get_node("Level1").get_node("Player")
	elif get_tree().root.get_node("Main").get_node_or_null("Level2"):
		player = get_tree().root.get_node("Main").get_node("Level2").get_node("Player")
	elif get_tree().root.get_node("Main").get_node_or_null("Level3"):
		player = get_tree().root.get_node("Main").get_node("Level3").get_node("Player")
	elif get_tree().root.get_node("Main").get_node_or_null("FinalBoss"):
		player = get_tree().root.get_node("Main").get_node("FinalBoss").get_node("Player")


# Makes sure enemy is facing the player
func face_player():
	direction = (player.position - self.position).normalized()
	if direction.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true


# Returns true if currently facing the player, false otherwise
func is_facing_player():
	direction = (player.position - self.position).normalized()
	if direction.x > 0:
		if anim.flip_h == false:
			return true
	elif anim.flip_h == true:
		return true
	
	return false


func run_left():
	anim.play("Run")
	get_node("AnimatedSprite2D").flip_h = true
	direction = -1


func run_right():
	anim.play("Run")
	get_node("AnimatedSprite2D").flip_h = false
	direction = 1


# Flips direction if Enemy hits wall
func wall_to_wall():
	if anim.animation != "Death":
		if is_on_wall():
			if get_node("AnimatedSprite2D").flip_h == false:
				get_node("AnimatedSprite2D").flip_h = true
				direction = -1
			else:
				get_node("AnimatedSprite2D").flip_h = false
				direction = 1


func chase():
	face_player()
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed


func death():
	if collision_shape:
		collision_shape.set_deferred("disabled", true)
	anim.play("Death")
	death_sound.play()
	cry_sound.play()
	await anim.animation_finished
	self.queue_free()


# On death, player "extra jumps"
func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			death()
			body.extra_jump = true


# If collided into by player, player dies
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			body.pause = true
			body.hurt_sound.play()
			body.death_timer.start()
			await body.hurt_sound.finished
